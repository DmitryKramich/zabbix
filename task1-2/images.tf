provider "google" {
  credentials = "terraform-admin.json"
  project     = var.project
  region      = var.region
}

# create server
resource "google_compute_instance" "lpad_server" {
  name            = "ldap-server"
  can_ip_forward  = true
  machine_type    = var.machine_type
  zone            = var.zone
  tags            = var.ldap_tags 
  
  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  
  metadata_startup_script = templatefile("ldap+gui.sh", {
    key = "${var.pubkey}" })
	
  depends_on = [google_compute_subnetwork.public]
  
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
    access_config {}
  }
}

resource "google_compute_instance" "zabbix_server" {
  name         = "zabbix-server"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.zabbix_srv_tags

  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  
  depends_on = [google_compute_subnetwork.public]
  
  metadata_startup_script = file("zabbix-server.sh")
	
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
	access_config {}
  }
}

locals {
  srv_zabbix_ip = google_compute_instance.zabbix_server.network_interface.0.network_ip
}


resource "google_compute_instance" "zabbix_client" {
  name         = "zabbix-client"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.zabbix_ag_tags

  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  
  depends_on = [google_compute_subnetwork.public]
  
  metadata_startup_script = templatefile("zabbix-client.sh", {
    zabbix_ip = "${local.srv_zabbix_ip}" })
	
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
	access_config {}
  }
}


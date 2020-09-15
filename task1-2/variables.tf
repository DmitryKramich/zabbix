variable "project" {}

variable "region" {}

variable "zone" {}

variable "machine_type" {}

variable "disk_size" {}

variable "disk_type" {}

variable "images" {}

variable "student_name" {}

variable "external_ranges" {
	type = list
}

variable "external_http_ports" {
	type = list 
}

variable "ssh_external_ports" {
	type = list 
}

variable "ldap_ports" {
	type = list
}

variable "internal_ranges" {
	type = list
}

variable "zabbix_ports" {
	type = list
}

variable "public_subnet" {}

variable "private_subnet" {}

variable "subnetwork_custom_public" {}

variable "subnetwork_custom_private" {}

variable "network_custom_vpc" {}

variable "ldap_tags" {
	type    = list
}

variable "zabbix_tags" {
	type    = list
}

variable "zabbix_srv_tags" {
	type    = list
}

variable "zabbix_ag_tags" {
	type    = list
}

variable "target_serv_tags" {
	type    = list
}

variable "pubkey" {}
project       = "compact-retina-288017"
region        = "us-central1"
zone          = "us-central1-c"
machine_type  = "custom-1-4608"
disk_type     = "pd-ssd"
disk_size     = 35
images        = "centos-cloud/centos-7"

#network options 
student_name          = "dk"
external_http_ports   = ["80","443","587","8080"]
ssh_external_ports    = ["22"]
external_ranges       = ["0.0.0.0/0"]
ldap_ports            = ["389","636"]
zabbix_ports          = ["10050","10051"]
internal_ranges       = ["10.2.0.0/24"]
public_subnet         = "10.2.1.0/24"
private_subnet        = "10.2.2.0/24"
ldap_tags             = ["ldap-server"]
zabbix_srv_tags       = ["zabbix-srv"]
zabbix_ag_tags        = ["zabbix-ag"]
zabbix_tags           = ["zabbix-ag","zabbix-srv"]
target_serv_tags      = ["zabbix-ag","zabbix-srv","ldap-server"]

network_custom_vpc        = "dk-vpc"
subnetwork_custom_public  = "public-subnet"
subnetwork_custom_private = "private-subnet"

#ssh.pub key
pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxMX8+qvhM9TxdFYXwOZz48XcB4pEEqZgSnCn+iRl2eYia/vJl8hMtibnvoMaMJdEUR/JcwioM/sLg95QT/6abQEKG2HlW/27FVo+BPSbpirpQZJ67baU/dWOPpBH3HTfxbstBCwIB3mcGaBOn2qTgaii+1YVxO/Y9lfgsR0/NuyWLMNIkv3lCyMyYMbEok5OFR2iduiu49JA5ywD30NLr0Oj9SMZlOT9qe2QWGmaW/OZEbS70ZHcyEcsawXUlUnKd/B1UZ7cNilF6h8WfgLjZ5EIHg8FJaHuKrRwJMiNnlRg9Ig/onAWnHD/RJrFRLfaud7iWjsW7dxT1VgIe96jLdN1d7LeV76Wu54aIvHjunm8V6D67t8NWKCY5l2nAImIiWOaV5K2yVMfjjINEwYlWIMHo8KfZZZZ14z7bYgU3AUasUELbNzZLwNyD/r8raoHAvm/oDZBDVkJ+ZU7Eq29ZCyEj5h1J9bJUC66Ldy/gV1Q/0Xf9JOH2mg9L37FXscdF+hwmylbYtn6brbndrfE711umW36XsQxfeUmNQ+MPfe3OHIp34m2PJ93rbr7IEj19gTpF3j5jxTxMfnwWNS5knLNdj5ol4MZoAVxzHoDyKiPs5YYl3/1tSy8rkDGhTkvClMtESWRwDiMdaenvDlxyC5JwIZEgbLfFbj3r6U23zQ== dkramich@localhost.localdomain"
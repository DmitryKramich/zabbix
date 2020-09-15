output "zabbix-server" {
  value = "http://${google_compute_instance.zabbix_server.network_interface.0.access_config.0.nat_ip}/zabbix/"
}

output "zabbix-client" {
  value = "${google_compute_instance.zabbix_client.network_interface.0.access_config.0.nat_ip}"
}

output "tomcat" {
  value = "http://${google_compute_instance.zabbix_client.network_interface.0.access_config.0.nat_ip}:8080/sample"
}
output "webserver_external_ip" {
  value = yandex_compute_instance.webserver.network_interface[*].nat_ip_address
}

output "webserver_internal_ip" {
  value = yandex_compute_instance.webserver.network_interface[*].ip_address
}

output "url" {
  value = "http://${yandex_compute_instance.webserver.network_interface[0].nat_ip_address}:80"
}

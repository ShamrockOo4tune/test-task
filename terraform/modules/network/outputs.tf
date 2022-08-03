output "custom_vpc_network_id" {
  value       = yandex_vpc_network.custom.id
  description = "ID of created custom vpc network"
}

output "custom_vpc_subnet_id" {
  value       = yandex_vpc_subnet.custom.id
  description = "ID of the custom vpc subnet"
}

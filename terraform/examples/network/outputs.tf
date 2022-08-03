output "custom_vpc_network_id" {
  value       = module.network.custom_vpc_network_id
  description = "ID of created custom vpc network"
}

output "custom_vpc_subnet_id" {
  value       = module.network.custom_vpc_subnet_id
  description = "ID of the custom vpc subnet"
}

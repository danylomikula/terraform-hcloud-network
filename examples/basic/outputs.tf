output "network_id" {
  description = "ID of the created network."
  value       = module.network.network_id
}

output "network_name" {
  description = "Name of the created network."
  value       = module.network.network_name
}

output "network_ip_range" {
  description = "CIDR of the created network."
  value       = module.network.network_ip_range
}

output "subnets" {
  description = "Details about the subnets created by this module."
  value       = module.network.subnets
}

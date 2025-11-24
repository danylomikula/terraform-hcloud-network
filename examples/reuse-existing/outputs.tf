output "subnet_ids_by_zone" {
  description = "Aggregated subnet IDs returned by the module for quick inspection."
  value       = module.network_reuse.subnet_ids_by_zone
}

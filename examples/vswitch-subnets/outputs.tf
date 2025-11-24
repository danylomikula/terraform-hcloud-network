output "vswitch_subnet_ids" {
  description = "IDs of the vSwitch-backed subnets in this example."
  value       = module.network_vswitch.vswitch_subnet_ids
}

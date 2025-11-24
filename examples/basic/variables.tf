variable "hcloud_token" {
  description = "Hetzner Cloud API token used by the example configuration."
  type        = string
  sensitive   = true
}

variable "vswitch_id" {
  description = "ID of an existing Hetzner Cloud vSwitch used for the workloads subnet example."
  type        = number
}

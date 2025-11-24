variable "hcloud_token" {
  description = "Hetzner Cloud API token used by the example configuration."
  type        = string
  sensitive   = true
}

variable "existing_network_name" {
  description = "Name of a pre-existing Hetzner network that should be extended with new subnets."
  type        = string
}

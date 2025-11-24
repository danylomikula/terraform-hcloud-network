variable "hcloud_token" {
  description = "Hetzner Cloud API token used by the example configuration."
  type        = string
  sensitive   = true
}

variable "existing_network_id" {
  description = "ID of the Hetzner network where routes will be managed."
  type        = number
}

variable "gateway_ip" {
  description = "IP address used as the default internet gateway for the network."
  type        = string
}

variable "vpn_gateway_ip" {
  description = "IP address of the VPN appliance that backhauls traffic to on-prem networks."
  type        = string
}

variable "create_network" {
  description = "When true, the module creates the Hetzner Cloud network; when false, an existing network ID must be provided."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name for the Hetzner Cloud network. Required when create_network is true."
  type        = string
  default     = null

  validation {
    condition     = !var.create_network || (var.name != null && trimspace(var.name) != "")
    error_message = "A non-empty name must be provided when create_network is true."
  }
}

variable "ip_range" {
  description = "CIDR of the Hetzner Cloud network (for example 10.0.0.0/16). Required when create_network is true."
  type        = string
  default     = null

  validation {
    condition     = !var.create_network || (var.ip_range != null && trimspace(var.ip_range) != "")
    error_message = "A CIDR block must be provided when create_network is true."
  }
}

variable "labels" {
  description = "Labels applied to the network and subnets."
  type        = map(string)
  default     = {}
}

variable "existing_network_id" {
  description = "ID of an existing Hetzner Cloud network to reuse when create_network is false."
  type        = number
  default     = null

  validation {
    condition = (
      var.create_network ||
      var.existing_network_id != null ||
      try(trimspace(var.existing_network_name), "") != ""
    )
    error_message = "Provide either existing_network_id or existing_network_name when create_network is false."
  }
}

variable "existing_network_name" {
  description = "Name of an existing Hetzner Cloud network to reuse when create_network is false."
  type        = string
  default     = null

  validation {
    condition     = var.existing_network_name == null || try(trimspace(var.existing_network_name), "") != ""
    error_message = "existing_network_name must be non-empty when provided."
  }
}

variable "subnets" {
  description = "Map of subnet definitions keyed by an arbitrary name."
  type = map(object({
    type         = string
    network_zone = string
    ip_range     = string
    vswitch_id   = optional(number)
  }))
  default = {}

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) : contains(["cloud", "server", "vswitch"], subnet.type)
    ])
    error_message = "Every subnet.type value must be one of: \"cloud\", \"server\", \"vswitch\"."
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      subnet.type == "vswitch" ? subnet.vswitch_id != null : true
    ])
    error_message = "Each subnet with type \"vswitch\" must specify vswitch_id."
  }
}

variable "routes" {
  description = "Optional map of custom routes to configure inside the network."
  type = map(object({
    destination = string
    gateway     = string
  }))
  default = {}
}

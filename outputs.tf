output "network_id" {
  description = "ID of the Hetzner Cloud network managed (or referenced) by this module."
  value       = local.network_id
}

output "network_name" {
  description = "Name of the Hetzner Cloud network."
  value       = local.effective_network.name
}

output "network_ip_range" {
  description = "CIDR of the Hetzner Cloud network."
  value       = local.effective_network.ip_range
}

output "network_labels" {
  description = "Labels currently set on the network object."
  value       = local.effective_network.labels
}

output "subnets" {
  description = "Details about the subnets created by this module."
  value = {
    for key, subnet in hcloud_network_subnet.this :
    key => {
      id           = subnet.id
      ip_range     = subnet.ip_range
      network_zone = subnet.network_zone
      type         = subnet.type
      vswitch_id   = subnet.vswitch_id
    }
  }
}

output "routes" {
  description = "Routes configured in the network through this module."
  value = {
    for key, route in hcloud_network_route.this :
    key => {
      id          = route.id
      destination = route.destination
      gateway     = route.gateway
    }
  }
}

output "subnet_ids_by_zone" {
  description = "Map of network zones to the IDs of subnets created in each zone."
  value = {
    for zone in distinct([for subnet in values(hcloud_network_subnet.this) : subnet.network_zone]) :
    zone => [
      for subnet in values(hcloud_network_subnet.this) : subnet.id
      if subnet.network_zone == zone
    ]
  }
}

output "vswitch_subnet_ids" {
  description = "List of subnet IDs that are associated with vSwitch subnets."
  value       = [for subnet in values(hcloud_network_subnet.this) : subnet.id if subnet.type == "vswitch"]
}

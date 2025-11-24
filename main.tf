resource "hcloud_network" "this" {
  count = var.create_network ? 1 : 0

  name     = var.name
  ip_range = var.ip_range
  labels   = var.labels
}

data "hcloud_network" "existing_by_id" {
  count = var.create_network || var.existing_network_id == null ? 0 : 1
  id    = var.existing_network_id
}

data "hcloud_network" "existing_by_name" {
  count = var.create_network || var.existing_network_id != null || var.existing_network_name == null ? 0 : 1
  name  = var.existing_network_name
}

locals {
  created_network = var.create_network ? one(hcloud_network.this) : null
  existing_network = var.create_network ? null : (
    var.existing_network_id != null ? one(data.hcloud_network.existing_by_id) : one(data.hcloud_network.existing_by_name)
  )
  effective_network = var.create_network ? local.created_network : local.existing_network
  network_id        = local.effective_network.id
}

resource "hcloud_network_subnet" "this" {
  for_each = var.subnets

  network_id   = local.network_id
  type         = each.value.type
  network_zone = each.value.network_zone
  ip_range     = each.value.ip_range
  vswitch_id   = try(each.value.vswitch_id, null)
}

resource "hcloud_network_route" "this" {
  for_each = var.routes

  network_id  = local.network_id
  destination = each.value.destination
  gateway     = each.value.gateway
}

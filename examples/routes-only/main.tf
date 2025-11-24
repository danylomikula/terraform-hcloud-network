terraform {
  required_version = ">= 1.12.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.44.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

module "network_routes" {
  source = "../.."

  create_network      = false
  existing_network_id = var.existing_network_id

  routes = {
    internet-egress = {
      destination = "0.0.0.0/0"
      gateway     = var.gateway_ip
    }

    vpn-backhaul = {
      destination = "172.16.0.0/12"
      gateway     = var.vpn_gateway_ip
    }
  }
}

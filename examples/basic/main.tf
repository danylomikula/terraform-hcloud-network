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

module "network" {
  source = "../.."

  create_network = true
  name           = "lab-network"
  ip_range       = "10.42.0.0/16"

  labels = {
    environment = "lab"
    managed_by  = "terraform"
  }

  subnets = {
    dmz = {
      type         = "cloud"
      network_zone = "eu-central"
      ip_range     = "10.42.10.0/24"
    }

    workloads = {
      type         = "vswitch"
      network_zone = "eu-central"
      ip_range     = "10.42.20.0/24"
      vswitch_id   = var.vswitch_id
    }
  }
}

# Note: Servers from different locations (fsn1, nbg1, hel1) can all connect
# to this network since they're all in the eu-central network zone.
# Example:
#   - Server in fsn1 with IP 10.42.10.5
#   - Server in nbg1 with IP 10.42.10.6
#   - Server in hel1 with IP 10.42.10.7
# All can communicate with each other over the private network.

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

module "network_reuse" {
  source = "../.."

  create_network        = false
  existing_network_name = var.existing_network_name

  subnets = {
    workers = {
      type         = "server"
      network_zone = "eu-central"
      ip_range     = "10.50.10.0/24"
    }

    services = {
      type         = "cloud"
      network_zone = "eu-west"
      ip_range     = "10.50.20.0/24"
    }
  }

  routes = {
    default-egress = {
      destination = "0.0.0.0/0"
      gateway     = "10.50.10.1"
    }
  }
}

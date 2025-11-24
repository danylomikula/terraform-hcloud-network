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

module "network_vswitch" {
  source = "../.."

  create_network = true
  name           = "vswitch-segment"
  ip_range       = "10.80.0.0/16"

  labels = {
    environment = "lab"
    feature     = "vswitch"
  }

  subnets = {
    core = {
      type         = "vswitch"
      network_zone = "eu-central" # vSwitch only works in eu-central
      ip_range     = "10.80.10.0/24"
      vswitch_id   = 12345 # Replace with your vSwitch ID from https://robot.hetzner.com
    }

    storage = {
      type         = "vswitch"
      network_zone = "eu-central" # vSwitch only works in eu-central
      ip_range     = "10.80.20.0/24"
      vswitch_id   = 67890 # Replace with your vSwitch ID from https://robot.hetzner.com
    }
  }
}

# Note: Before running this example:
# 1. Create vSwitches in Hetzner Robot: https://robot.hetzner.com
# 2. Replace the vswitch_id values above with your actual vSwitch IDs
# 3. vSwitch coupling only works in eu-central network zone

# Hetzner Cloud Terraform Module

[![Release](https://img.shields.io/github/v/release/danylomikula/terraform-hcloud-network)](https://github.com/danylomikula/terraform-hcloud-network/releases)
[![Pre-Commit](https://github.com/danylomikula/terraform-hcloud-network/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/danylomikula/terraform-hcloud-network/actions/workflows/pre-commit.yml)
[![License](https://img.shields.io/github/license/danylomikula/terraform-hcloud-network)](https://github.com/danylomikula/terraform-hcloud-network/blob/main/LICENSE)

Terraform module that provisions and manages Hetzner Cloud networks, subnets, and routes.

## Features
- Optional creation of a new Hetzner Cloud network or reuse of an existing one
- Ability to reference existing networks by either ID or name when reusing infrastructure
- Support for multiple subnets across network zones and subnet types (`server`, `cloud`, or `vswitch`)
- Optional custom routes for advanced scenarios (VPN gateways, proxy servers)
- Helper outputs with aggregated subnet IDs (per zone and for vSwitch subnets) to simplify downstream wiring
- Consistent outputs that expose identifiers and computed attributes for downstream modules

## Important Limitations

**Network Zone Constraint**: All subnets within a single Hetzner Cloud network must be in the same network zone (e.g., `eu-central`, `us-east`, `us-west`, `ap-southeast`).

**What you CAN do**:
- ✅ Create network with subnets in any single zone (`eu-central`, `us-east`, `us-west`, `ap-southeast`)
- ✅ Connect servers from different locations within that zone (e.g., fsn1, nbg1, hel1 all in `eu-central`)
- ✅ All servers in the network can communicate via private IPs regardless of their specific location

**What you CANNOT do**:
- ❌ Mix network zones in one network (e.g., `eu-central` + `us-east` subnets in same network)
- ❌ Create a single network spanning Europe and USA

**If you need resources in multiple network zones**: Create separate networks for each zone:
- Network A in `eu-central` for European resources
- Network B in `us-east` for USA resources
- Servers in different networks cannot communicate via private IPs

This is documented in [Hetzner Cloud Networks FAQ](https://docs.hetzner.com/cloud/networks/faq/#can-networks-span-multiple-locations):
> "all locations within a Network have to be from the same network zone as the subnet. All subnets within a Network also have to be from the same network zone."

**vSwitch Limitation**: vSwitch subnets (for connecting dedicated servers) only work in `eu-central` network zone. You must create vSwitches in [Hetzner Robot](https://robot.hetzner.com) first, then reference their IDs in your configuration.

## Usage
```hcl
module "hcloud_network" {
  source  = "danylomikula/network/hcloud"
  version = "~> 1.0"

  create_network = true
  name           = "lab-core"
  ip_range       = "10.10.0.0/16"

  labels = {
    environment = "lab"
    owner       = "platform"
  }

  subnets = {
    edge = {
      type         = "cloud"
      network_zone = "eu-central"
      ip_range     = "10.10.10.0/24"
    }

    # vSwitch subnet for connecting dedicated servers
    # Note: vSwitch ID must be created in Hetzner Robot first
    # Only works in eu-central network zone
    compute = {
      type         = "vswitch"
      network_zone = "eu-central"
      ip_range     = "10.10.20.0/24"
      vswitch_id   = 12345  # from Robot console
    }
  }
}
```

To reuse an existing network by name and let the module manage only subnets/routes:

```hcl
module "hcloud_network_existing" {
  source  = "danylomikula/network/hcloud"
  version = "~> 1.0"

  create_network        = false
  existing_network_name = "lab-core-shared"

  subnets = {
    workers = {
      type         = "server"
      network_zone = "eu-central"
      ip_range     = "10.10.30.0/24"
    }
  }
}
```

Review the [examples](./examples) directory for a fully working configuration that you can copy into your environment.

### Example scenarios

| Directory | Description |
|-----------|-------------|
| `examples/basic` | Creates a new network with both standard and vSwitch subnets. |
| `examples/reuse-existing` | Reuses an existing network by name and only adds new subnets. Outputs aggregated subnet IDs for quick consumption. |
| `examples/vswitch-subnets` | Focuses on vSwitch-backed subnets that attach to pre-existing vSwitch IDs supplied via variables. |
| `examples/routes-only` | Demonstrates managing custom routes on an existing network (e.g., for VPN gateway or proxy server scenarios). |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.44.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.44.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_network.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_route.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route) | resource |
| [hcloud_network_subnet.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network.existing_by_id](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/network) | data source |
| [hcloud_network.existing_by_name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_network"></a> [create\_network](#input\_create\_network) | When true, the module creates the Hetzner Cloud network; when false, an existing network ID must be provided. | `bool` | `true` | no |
| <a name="input_existing_network_id"></a> [existing\_network\_id](#input\_existing\_network\_id) | ID of an existing Hetzner Cloud network to reuse when create\_network is false. | `number` | `null` | no |
| <a name="input_existing_network_name"></a> [existing\_network\_name](#input\_existing\_network\_name) | Name of an existing Hetzner Cloud network to reuse when create\_network is false. | `string` | `null` | no |
| <a name="input_ip_range"></a> [ip\_range](#input\_ip\_range) | CIDR of the Hetzner Cloud network (for example 10.0.0.0/16). Required when create\_network is true. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to the network and subnets. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Hetzner Cloud network. Required when create\_network is true. | `string` | `null` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | Optional map of custom routes to configure inside the network. | <pre>map(object({<br/>    destination = string<br/>    gateway     = string<br/>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of subnet definitions keyed by an arbitrary name. | <pre>map(object({<br/>    type         = string<br/>    network_zone = string<br/>    ip_range     = string<br/>    vswitch_id   = optional(number)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the Hetzner Cloud network managed (or referenced) by this module. |
| <a name="output_network_ip_range"></a> [network\_ip\_range](#output\_network\_ip\_range) | CIDR of the Hetzner Cloud network. |
| <a name="output_network_labels"></a> [network\_labels](#output\_network\_labels) | Labels currently set on the network object. |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the Hetzner Cloud network. |
| <a name="output_routes"></a> [routes](#output\_routes) | Routes configured in the network through this module. |
| <a name="output_subnet_ids_by_zone"></a> [subnet\_ids\_by\_zone](#output\_subnet\_ids\_by\_zone) | Map of network zones to the IDs of subnets created in each zone. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Details about the subnets created by this module. |
| <a name="output_vswitch_subnet_ids"></a> [vswitch\_subnet\_ids](#output\_vswitch\_subnet\_ids) | List of subnet IDs that are associated with vSwitch subnets. |
<!-- END_TF_DOCS -->

## Related Modules

| Module | Description | GitHub | Terraform Registry |
|--------|-------------|--------|-------------------|
| **terraform-hcloud-server** | Manage Hetzner Cloud servers | [GitHub](https://github.com/danylomikula/terraform-hcloud-server) | [Registry](https://registry.terraform.io/modules/danylomikula/server/hcloud) |
| **terraform-hcloud-firewall** | Manage Hetzner Cloud firewalls | [GitHub](https://github.com/danylomikula/terraform-hcloud-firewall) | [Registry](https://registry.terraform.io/modules/danylomikula/firewall/hcloud) |
| **terraform-hcloud-ssh-key** | Manage Hetzner Cloud SSH keys | [GitHub](https://github.com/danylomikula/terraform-hcloud-ssh-key) | [Registry](https://registry.terraform.io/modules/danylomikula/ssh-key/hcloud) |

## Authors

Module managed by [Danylo Mikula](https://github.com/danylomikula).

## Contributing

Contributions are welcome! Please read the [Contributing Guide](.github/contributing.md) for details on the process and commit conventions.

## License

Apache 2.0 Licensed. See [LICENSE](LICENSE) for full details.

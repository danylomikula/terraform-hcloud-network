# Examples

This directory contains examples demonstrating how to use the Hetzner Cloud Network module.

## Available Examples

| Example | Description |
|---------|-------------|
| [basic](./basic/) | Create a network with standard and vSwitch subnets and a default route |
| [reuse-existing](./reuse-existing/) | Reference an existing network by name and attach extra subnets/routes |
| [vswitch-subnets](./vswitch-subnets/) | Create only vSwitch-backed subnets with pre-created Hetzner vSwitch IDs |
| [routes-only](./routes-only/) | Manage routes for an existing network without creating subnets |

## Usage

Each example can be run independently:

```bash
cd examples/basic
export TF_VAR_hcloud_token="your-api-token"
terraform init
terraform apply
```

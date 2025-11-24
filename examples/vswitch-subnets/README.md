# vSwitch Subnets Example

This example demonstrates how to create a Hetzner Cloud network with only vSwitch-backed subnets.

## What it creates

- A network named `vswitch-segment` with IP range `10.80.0.0/16`
- Two vSwitch subnets:
  - **core**: vSwitch subnet in `eu-central` zone (`10.80.10.0/24`)
  - **storage**: vSwitch subnet in `eu-central` zone (`10.80.20.0/24`)
- Labels for organization (`environment=lab`, `feature=vswitch`)

## Prerequisites

1. Create vSwitches in [Hetzner Robot](https://robot.hetzner.com)
2. Replace the `vswitch_id` values in `main.tf` with your actual vSwitch IDs
3. Note: vSwitch coupling only works in `eu-central` network zone

## Usage

```bash
export TF_VAR_hcloud_token="your-api-token"
terraform init
terraform plan
terraform apply
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.44.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network_vswitch"></a> [network\_vswitch](#module\_network\_vswitch) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token used by the example configuration. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vswitch_subnet_ids"></a> [vswitch\_subnet\_ids](#output\_vswitch\_subnet\_ids) | IDs of the vSwitch-backed subnets in this example. |
<!-- END_TF_DOCS -->

# Reuse Existing Network Example

This example demonstrates how to reference an existing Hetzner Cloud network by name and attach additional subnets and routes.

## What it creates

- References an existing network by name (does not create a new network)
- Two subnets attached to the existing network:
  - **workers**: Server subnet in `eu-central` zone (`10.50.10.0/24`)
  - **services**: Cloud subnet in `eu-west` zone (`10.50.20.0/24`)
- One route:
  - **default-egress**: Routes `0.0.0.0/0` through gateway `10.50.10.1`

## Usage

```bash
export TF_VAR_hcloud_token="your-api-token"
export TF_VAR_existing_network_name="your-network-name"
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
| <a name="module_network_reuse"></a> [network\_reuse](#module\_network\_reuse) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_network_name"></a> [existing\_network\_name](#input\_existing\_network\_name) | Name of a pre-existing Hetzner network that should be extended with new subnets. | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token used by the example configuration. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_ids_by_zone"></a> [subnet\_ids\_by\_zone](#output\_subnet\_ids\_by\_zone) | Aggregated subnet IDs returned by the module for quick inspection. |
<!-- END_TF_DOCS -->

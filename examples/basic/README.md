# Basic Example

This example demonstrates how to create a Hetzner Cloud network with standard and vSwitch subnets.

## What it creates

- A network named `lab-network` with IP range `10.42.0.0/16`
- Two subnets:
  - **dmz**: Cloud subnet in `eu-central` zone (`10.42.10.0/24`)
  - **workloads**: vSwitch subnet in `eu-central` zone (`10.42.20.0/24`)
- Labels for organization (`environment=lab`, `managed_by=terraform`)

## Usage

```bash
export TF_VAR_hcloud_token="your-api-token"
export TF_VAR_vswitch_id="your-vswitch-id"
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
| <a name="module_network"></a> [network](#module\_network) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token used by the example configuration. | `string` | n/a | yes |
| <a name="input_vswitch_id"></a> [vswitch\_id](#input\_vswitch\_id) | ID of an existing Hetzner Cloud vSwitch used for the workloads subnet example. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the created network. |
| <a name="output_network_ip_range"></a> [network\_ip\_range](#output\_network\_ip\_range) | CIDR of the created network. |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the created network. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Details about the subnets created by this module. |
<!-- END_TF_DOCS -->

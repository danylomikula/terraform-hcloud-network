# Routes Only Example

This example demonstrates how to manage routes for an existing Hetzner Cloud network without creating any subnets.

## What it creates

- References an existing network by ID (does not create a new network)
- Two routes:
  - **internet-egress**: Routes `0.0.0.0/0` through a specified gateway
  - **vpn-backhaul**: Routes `172.16.0.0/12` through a VPN gateway

## Usage

```bash
export TF_VAR_hcloud_token="your-api-token"
export TF_VAR_existing_network_id="your-network-id"
export TF_VAR_gateway_ip="10.0.0.1"
export TF_VAR_vpn_gateway_ip="10.0.0.2"
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
| <a name="module_network_routes"></a> [network\_routes](#module\_network\_routes) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_network_id"></a> [existing\_network\_id](#input\_existing\_network\_id) | ID of the Hetzner network where routes will be managed. | `number` | n/a | yes |
| <a name="input_gateway_ip"></a> [gateway\_ip](#input\_gateway\_ip) | IP address used as the default internet gateway for the network. | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token used by the example configuration. | `string` | n/a | yes |
| <a name="input_vpn_gateway_ip"></a> [vpn\_gateway\_ip](#input\_vpn\_gateway\_ip) | IP address of the VPN appliance that backhauls traffic to on-prem networks. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_routes"></a> [routes](#output\_routes) | Route objects returned by the module for verification. |
<!-- END_TF_DOCS -->

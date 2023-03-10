# Overview
This module creates an Azure Storage Account with settings suitable for Terraform State in Azure.  The Storage Account created has the following properties:
* The storage is configured to help recover from corruption or other damage:
   * Version, chnage feed, and last access time enabled. 
   * [Geo-zone-redundant storage (GZRS)](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy#geo-zone-redundant-storage)
   * Blobs and containers retained for a configurable amount of time.
* Network security controls:
  * By default access from the Internet is denied.
  * Optionally, a Private End-Point can be created, access can be allowed from select public IPs of Azure vNets.

------------

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0, <4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0.0, <4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.l0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.l1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.l2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.l3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.l4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bypass_network_rules"></a> [bypass\_network\_rules](#input\_bypass\_network\_rules) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `list(string)` | <pre>[<br>  "None"<br>]</pre> | no |
| <a name="input_create_private_endpoint"></a> [create\_private\_endpoint](#input\_create\_private\_endpoint) | Will create a service endpoint if set to True | `string` | `false` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Location for the Resource Group and other resources. | `string` | n/a | yes |
| <a name="input_private_dns_zone_group_name"></a> [private\_dns\_zone\_group\_name](#input\_private\_dns\_zone\_group\_name) | The name of the Private DNS Zone Group. | `string` | `"private-dns-zone-group"` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Subnet ID used for private endpoint. | `string` | `null` | no |
| <a name="input_sa_container_delete_retention_policy_days"></a> [sa\_container\_delete\_retention\_policy\_days](#input\_sa\_container\_delete\_retention\_policy\_days) | Specifies the number of days that the blob should be retained, between 1 and 365 days.  Default is 30 days | `number` | `30` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | Storage Account Name | `string` | n/a | yes |
| <a name="input_sa_rg_name"></a> [sa\_rg\_name](#input\_sa\_rg\_name) | Name of the Resource Group to contain the Storage Account. | `string` | n/a | yes |
| <a name="input_storage_blob_private_dns_zone_ids"></a> [storage\_blob\_private\_dns\_zone\_ids](#input\_storage\_blob\_private\_dns\_zone\_ids) | Private DNS Zone Ids for the blob service of Azure Storage Account. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags for Azure Resources. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | A list of subnet resource ids that can communicate with the Storage Account. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sa_id"></a> [sa\_id](#output\_sa\_id) | The resource ID of the storage account. |
| <a name="output_sa_location"></a> [sa\_location](#output\_sa\_location) | The location used for the storage account. |
| <a name="output_sa_name"></a> [sa\_name](#output\_sa\_name) | The name of the Log Analytics Workspace. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
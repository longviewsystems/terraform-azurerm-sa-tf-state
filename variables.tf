variable "location" {
  type        = string
  description = "Location for the Resource Group and other resources."
}

variable "tags" {
  type        = map(string)
  description = "List of tags for Azure Resources."
  default     = {}
}

/**** Storage Account ***/

variable "sa_rg_name" {
  type        = string
  description = "Name of the Resource Group to contain the Storage Account."
}

variable "sa_name" {
  type        = string
  description = "Storage Account Name"
}

# Set the retention period for deleted blobs.
variable "sa_container_delete_retention_policy_days" {
  type        = number
  description = " Specifies the number of days that the blob should be retained, between 1 and 365 days.  Default is 30 days"
  default     = 30
}

variable "containers_add_level" {
  type        = bool
  description = "Add lvl0, lvl1, lvl2, lvl3, lvl4 containers to the Storage Account."
  default     = true
}

variable "containers_additional_containers" {
  type        = map(string)
  description = "Add containers with various names."
  default     = {}
}

/***************************************************************/
/*** Networking
/***************************************************************/
variable "public_network_access_enabled" {
  type        = bool
  description = "Enables or disables public network access.  The Storage Account is not accessible to the Internet when set to false."
  default     = true
}

variable "bypass_network_rules" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["None"]
}

variable "ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
  default     = []
}

variable "virtual_network_subnet_ids" {
  type        = list(string)
  description = "A list of subnet resource ids that can communicate with the Storage Account."
  default     = []
}

/***************************************************************/
/*** Private End-points
/***************************************************************/

variable "create_private_endpoint" {
  type        = string
  default     = false
  description = "Will create a service endpoint if set to True"
}

variable "private_dns_zone_group_name" {
  type        = string
  description = "The name of the Private DNS Zone Group. "
  default     = "private-dns-zone-group"
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Subnet ID used for private endpoint."
  default     = null
}

variable "storage_blob_private_dns_zone_ids" {
  type        = list(string)
  description = "Private DNS Zone Ids for the blob service of Azure Storage Account."
  default     = null
}
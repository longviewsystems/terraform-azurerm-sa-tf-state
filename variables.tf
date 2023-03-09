variable "location" {
  type        = string
  description = "Location for the Resource Group and other resources."
}

variable "prod_tags" {
  type        = map(string)
  description = "List of tags for Azure Resources"
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

/**** Key Vault ***/
variable "kv_rg_name" {
  type        = string
  description = "Name of the Resource Group that contains the Key Vault."
}

variable "kv_name" {
  type        = string
  description = "The Key Vault Name."
}
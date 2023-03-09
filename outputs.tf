output "sa_name" {
  value       = azurerm_storage_account.sa.name
  description = "The name of the Log Analytics Workspace."
}

output "sa_location" {
  value       = azurerm_storage_account.sa.location
  description = "The location used for the storage account."
}

output "sa_id" {
  value       = azurerm_storage_account.sa.id
  description = "The resource ID of the storage account."
}

locals {
  pe_sa_base_name = {
    blob  = lower("${var.sa_name}-blob-pe"),
    file  = lower("${var.sa_name}-file-pe"),
    queue = lower("${var.sa_name}-queue-pe"),
    table = lower("${var.sa_name}-table-pe"),
  }

  # if the function_name is not set, use the base name of the PE
  # pe_name = try(var.private_endpoint_name == "", true) ? local.pe_base_name : var.private_endpoint_name

}

resource "azurerm_private_endpoint" "sa" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = local.pe_sa_base_name["blob"]
  location            = var.location
  resource_group_name = var.sa_rg_name
  subnet_id           = var.private_endpoint_subnet_id

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.storage_blob_private_dns_zone_ids
  }

  private_service_connection {
    name                           = local.pe_sa_base_name["blob"]
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

}

#Create remote state storage account
resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.sa_rg_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GZRS"
  min_tls_version          = "TLS1_2"
  is_hns_enabled           = false

  network_rules {
    default_action             = "Deny"
    bypass                     = var.bypass_network_rules //["AzureServices"]
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true

    delete_retention_policy {
      days = var.sa_container_delete_retention_policy_days
    }

    container_delete_retention_policy {
      days = var.sa_container_delete_retention_policy_days
    }
  }

  tags = var.tags
}

#Create storage containers
resource "azurerm_storage_container" "l0" {
  name                  = "lvl0"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "l1" {
  name                  = "lvl1"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "l2" {
  name                  = "lvl2"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "l3" {
  name                  = "lvl3"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "l4" {
  name                  = "lvl4"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
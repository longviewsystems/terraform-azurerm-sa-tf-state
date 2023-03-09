#TODO: Fix this - PE should be created in module.
data "azurerm_private_endpoint_connection" "sa" {
  name                = "REPLACEME"
  resource_group_name = var.sa_rg_name
}

#Create remote state storage account
resource "azurerm_storage_account" "sa" {
  name = var.sa_name
  #resource_group_name      = azurerm_resource_group.rg.name
  resource_group_name      = var.sa_rg_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GZRS"
  min_tls_version          = "TLS1_2"
  is_hns_enabled           = false

  network_rules {
    default_action = "Allow"
    #bypass         = ["AzureServices"]
    #ip_rules       = ["REPLACEME"]

    private_link_access {
      endpoint_resource_id = data.azurerm_private_endpoint_connection.sa.id
    }
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
  #special tags for monitoring
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
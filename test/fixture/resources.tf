/*****************************************
/*   Naming conventions
/*****************************************/

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  prefix  = ["mod", "test"]
  # suffix = random_string.random.value

  unique-include-numbers = false
  unique-length          = 4
}

module "pe_naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  prefix  = ["mod", "pe", "test"]
  # suffix = random_string.random.value

  unique-include-numbers = false
  unique-length          = 4
}

/*****************************************
/*   Resource Group
/*****************************************/

resource "azurerm_resource_group" "fixture" {
  name     = module.naming.resource_group.name_unique
  location = var.location
  tags     = var.tags
}

/*****************************************
/*   Current IP
/*****************************************/
data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

/*****************************************
/*   Networking for PE
/*****************************************/
resource "azurerm_virtual_network" "fixture" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.fixture.location
  resource_group_name = azurerm_resource_group.fixture.name
}

resource "azurerm_subnet" "fixture" {
  name                 = "service"
  resource_group_name  = azurerm_resource_group.fixture.name
  virtual_network_name = azurerm_virtual_network.fixture.name
  address_prefixes     = ["10.0.1.0/24"]

  private_link_service_network_policies_enabled = true

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_private_dns_zone" "fixture" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.fixture.name
}
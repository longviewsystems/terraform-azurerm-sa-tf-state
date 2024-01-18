locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
  public_ip        = chomp(local.ifconfig_co_json.ip) //"${chomp(local.ifconfig_co_json.ip)}/32"
}

# Test plain module without PE
module "sa_test" {
  source = "../../"

  sa_rg_name = azurerm_resource_group.fixture.name
  location   = "westus2"

  ip_rules = [local.public_ip]

  sa_name = module.naming.storage_account.name_unique

  tags = var.tags

}

# Test module with PE
module "sa_test_with_pe" {
  source = "../../"

  sa_rg_name = azurerm_resource_group.fixture.name
  location   = "westus2"

  sa_name = module.pe_naming.storage_account.name_unique

  ip_rules                   = [local.public_ip] //["108.173.252.52"]//[local.public_ip]
  virtual_network_subnet_ids = [azurerm_subnet.fixture.id]

  create_private_endpoint           = true
  private_endpoint_subnet_id        = azurerm_subnet.fixture.id
  storage_blob_private_dns_zone_ids = [azurerm_private_dns_zone.fixture.id]

  tags = var.tags

}

# Test plain module without PE
module "sa_test3" {
  source = "../../"

  sa_rg_name = azurerm_resource_group.fixture.name
  location   = "westus2"

  ip_rules = [local.public_ip]

  containers_add_level = false

  containers_additional_containers = {
    folder1 = "tf-net",
    folder2 = "test2",
    folder3 = "tf-app"
  }

  sa_name = module.test3naming.storage_account.name_unique

  tags = var.tags

}
/*
Setup the module for testing.
*/

module "kv_test" {
  source = "../../"

  resource_group_name = azurerm_resource_group.fixture.name

  kv_name = module.naming.key_vault.name_unique

}
resource "azurerm_storage_account" "platform" {
  name = "hundeku3che2n"
  resource_group_name = azurerm_resource_group.platform.name

  location = var.platform_location
  account_tier = "Premium"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  tags = var.platform_resource_tags

}

resource "azurerm_storage_container" "bastions" {
  name                  = "bastions-vhds"
  resource_group_name   =  azurerm_resource_group.platform.name
  storage_account_name  = azurerm_storage_account.platform.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "testsb" {
  name = "sample.vhd"

  resource_group_name    = azurerm_resource_group.platform.name
  storage_account_name   = azurerm_storage_account.platform.name
  storage_container_name = azurerm_storage_container.bastions.name

  type = "page"
}
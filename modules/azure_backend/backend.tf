locals {
  //name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
  //1. take cluster_fqdn
  //2. make all letters lowercase
  //3. remove everything but lowercase letters and numbers
  //4. trim to 24 characters
  sa_name = substr(replace(lower(var.cluster_fqdn), "/[^0-9a-z]*/", ""), 0, 24)

  //only lowercase alphanumeric characters and hyphens allowed in "name":
  //1. take cluster_fqdn
  //2. make all letters lowercase
  //3. replace all chars that are not alphanumeric with hyphens
  //5. trim to 48 characters
  //6. remove potential trailing hyphen
  sc_name = replace(substr(replace(lower(var.cluster_fqdn), "/[^0-9a-z]/", "-"), 0, 48), "/(.*)-$/", "$1")
}


resource "azurerm_storage_account" "backend" {
  name                      = local.sa_name
  resource_group_name       = azurerm_resource_group.backend.name
  location                  = azurerm_resource_group.backend.location
  account_tier              = "standard"
  account_replication_type  = "LRS"
  tags                      = var.platform_resource_tags
  lifecycle {
    prevent_destroy         = true
    ignore_changes          = [
      name
    ]
  }
}

resource "azurerm_storage_container" "backend" {
  name                      = local.sc_name
  storage_account_name      = azurerm_storage_account.backend.name
  container_access_type     = "private"
  lifecycle {
    prevent_destroy         = true
    ignore_changes          = [
      name
    ]
  }
}

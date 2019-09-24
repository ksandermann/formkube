resource "random_string" "randomid" {
  length = 8
  upper = false
  lower = true
  number = true
  special = false
}

resource "azurerm_resource_group" "backend" {
  name      = "${var.platform_rg_name}RemoteState"
  location  = var.platform_location
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account" "backend" {
  //name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
  name                     = "terraformstate${random_string.randomid.result}"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "standard"
  account_replication_type = "LRS"
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "azurerm_storage_container" "backend" {
  //only lowercase alphanumeric characters and hyphens allowed in "name":
  name                  = "terraformstate${random_string.randomid.result}"
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      name
    ]
  }
}

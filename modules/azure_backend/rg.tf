resource "azurerm_resource_group" "backend" {
  name                = var.backend_resourcegroup_name
  location            = var.platform_location
  lifecycle {
    prevent_destroy   = true
  }
}

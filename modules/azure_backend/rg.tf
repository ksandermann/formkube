resource "azurerm_resource_group" "backend" {
  name                = var.state_rg_name
  location            = var.platform_location
  lifecycle {
    prevent_destroy   = true
  }
}

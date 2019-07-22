resource "azurerm_resource_group" "platform" {
  name      = var.platform_rg_name
  location  = var.platform_location
  tags      = var.platform_resource_tags
}

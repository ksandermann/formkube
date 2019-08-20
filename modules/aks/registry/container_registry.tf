resource "azurerm_container_registry" "acr" {
  name                     = "${var.platform_fqdn}containerRegistry"
  resource_group_name      = var.out_platform_rg_name
  location                 = var.platform_location
  tags                     = var.platform_resource_tags
  sku                      = var.registry_sku
  admin_enabled            = var.registry_admin_enabled
  georeplication_locations = ver.registry_georeplication_locations
}
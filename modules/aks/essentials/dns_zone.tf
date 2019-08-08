resource "azurerm_dns_zone" "platform" {
  name                = var.platform_fqdn
  resource_group_name = azurerm_resource_group.platform.name
  zone_type           = "Public"
  tags                = var.platform_resource_tags
  depends_on          = [azurerm_resource_group.platform]
}
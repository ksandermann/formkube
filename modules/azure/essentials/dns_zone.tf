resource "azurerm_dns_zone" "cluster" {
  name                = var.cluster_fqdn
  resource_group_name = azurerm_resource_group.platform.name
  zone_type           = "Public"
  tags                = var.platform_resource_tags
  depends_on          = [azurerm_resource_group.platform]
}
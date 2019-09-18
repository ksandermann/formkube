resource "azurerm_dns_zone" "platform" {
  name                = var.cluster_fqdn
  resource_group_name = azurerm_resource_group.platform.name
  //setting the zone_type results in a deprecation notice
  //reason: "This field was part of the initial Preview for Private DNS Zones - which has been replaced by the separate resource azurerm_private_dns_zone and will be removed in v2.0 of the Azure Provider."
  //zone_type does not need to be set here anymore, as Public is the default and private will not be supported in future releases -> we need Public anyway.
  //zone_type           = "Public"
  tags                = var.platform_resource_tags
  depends_on          = [azurerm_resource_group.platform]
}

output "out_platform_dns_zone_name_servers" {
  value       = azurerm_dns_zone.platform.name_servers
  description = "A list of values that make up the NS record for the zone."
}

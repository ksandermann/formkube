// need to output this to ensure resource group exists when applying other resources on first bootstrap
output "out_platform_rg_name" {
  value       = azurerm_resource_group.platform.name
  description = "Name of the ressource group that was created."
}

// need to output this to ensure dns zone exists when applying other resources on first bootstrap
output "out_platform_dns_zone_name" {
  value       = azurerm_dns_zone.platform.name
  description = "Name of the dns zone that was created."
}

output "out_platform_dns_zone_name_servers" {
  value       = azurerm_dns_zone.platform.name_servers
  description = "A list of values that make up the NS record for the zone."
}

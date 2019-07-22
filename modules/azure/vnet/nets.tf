resource "azurerm_virtual_network" "platform" {
  name                = var.cluster_fqdn
  resource_group_name = var.out_platform_rg_name
  location            = var.platform_location
  address_space       = var.platform_network_CIDRs
  tags                = var.platform_resource_tags
}

resource "azurerm_virtual_network" "platform" {
  name                = var.cluster_fqdn
  resource_group_name = var.out_platform_rg_name
  location            = var.platform_location
  address_space       = ["10.0.0.0/8"]
  tags                = var.platform_resource_tags
}

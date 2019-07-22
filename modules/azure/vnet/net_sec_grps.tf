resource "azurerm_network_security_group" "cluster" {
  name                = "cluster.${var.cluster_fqdn}"
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  tags                = var.platform_resource_tags
}

resource "azurerm_network_security_group" "bastions" {
  name                = "${var.bastions_vm_prefix}s.${var.cluster_fqdn}"
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  tags                = var.platform_resource_tags
}
resource "azurerm_subnet" "bastions" {
  name                 = "${var.bastions_vm_prefix}s.${var.cluster_fqdn}"
  resource_group_name  = var.out_platform_rg_name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.platform_network_bastion_subnet_CIDR
}

resource "azurerm_subnet" "cluster" {
  name                 = "cluster.${var.cluster_fqdn}"
  resource_group_name  = var.out_platform_rg_name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.platform_network_cluster_subnet_CIDR
}
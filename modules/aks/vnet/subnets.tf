resource "azurerm_subnet" "cluster" {
  name                 = "cluster.${var.cluster_fqdn}"
  resource_group_name  = var.out_platform_rg_name
  virtual_network_name = azurerm_virtual_network.platform.name
  //10.128.0.0 - 10.255.255.255
  address_prefix       = "10.128.0.0/9"
}
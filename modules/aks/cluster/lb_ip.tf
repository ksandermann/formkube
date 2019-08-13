resource "azurerm_public_ip" "loadbalancer" {
  name                = "${var.loadbalancer_dns_name}.${var.platform_fqdn}"
  location            = var.platform_location
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  ip_version          = "IPv4"
  allocation_method   = "Static"
  tags                = var.platform_resource_tags
  sku                 = "Standard"
  depends_on          = [azurerm_kubernetes_cluster.aks]
}
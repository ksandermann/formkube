resource "azurerm_lb_backend_address_pool" "masters" {
  resource_group_name = var.out_platform_rg_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "${var.masters_vm_prefix}s.${var.cluster_fqdn}"
  depends_on          = [azurerm_lb.loadbalancer]
}

resource "azurerm_lb_backend_address_pool" "nodes" {
  resource_group_name = var.out_platform_rg_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "nodes.${var.cluster_fqdn}"
  depends_on          = [azurerm_lb.loadbalancer]
}
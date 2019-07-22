resource "azurerm_lb_probe" "k8s_api" {
  resource_group_name = var.out_platform_rg_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "KubernetesAPI"
  port                = var.loadbalancer_k8s_api_backend_port
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 5
  depends_on          = [azurerm_lb.loadbalancer]
}

resource "azurerm_lb_probe" "ingresscontroller" {
  resource_group_name = var.out_platform_rg_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "IngressController"
  port                = var.loadbalancer_ingresscontroller_backend_port
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 5
  depends_on          = [azurerm_lb.loadbalancer]
}

resource "azurerm_lb_probe" "additional_node_probes" {
  count               = length(local.additional_node_rules_frontend_ports)
  resource_group_name = var.out_platform_rg_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "AdditionalNodeProbe${count.index}"
  port                = local.additional_node_rules_backend_ports[count.index]
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 5
  depends_on          = [azurerm_lb.loadbalancer]
}
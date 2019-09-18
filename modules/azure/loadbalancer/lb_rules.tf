resource "azurerm_lb_rule" "ingresscontroller" {
  resource_group_name            = var.out_platform_rg_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "IngressController"
  protocol                       = "Tcp"
  frontend_port                  = var.loadbalancer_ingresscontroller_frontend_port
  backend_port                   = var.loadbalancer_ingresscontroller_backend_port
  frontend_ip_configuration_name = azurerm_lb.loadbalancer.frontend_ip_configuration.0.name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.nodes.id
  //https://github.com/hashicorp/terraform/issues/9311#issuecomment-254068526
  //probe_id                        = "${azurerm_lb.loadbalancer.id}/probes/${azurerm_lb_probe.ingresscontroller.name}"
  // KNOWN ISSUE - see README.MD
  // probe_id                    = "${azurerm_lb_probe.ingress_controller.id}}"
  idle_timeout_in_minutes        = 5
  disable_outbound_snat          = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_lb_rule" "k8s_api" {
  resource_group_name            = var.out_platform_rg_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "KubernetesAPI"
  protocol                       = "Tcp"
  frontend_port                  = var.loadbalancer_k8s_api_frontend_port
  backend_port                   = var.loadbalancer_k8s_api_backend_port
  frontend_ip_configuration_name = azurerm_lb.loadbalancer.frontend_ip_configuration.0.name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.masters.id
  //https://github.com/hashicorp/terraform/issues/9311#issuecomment-254068526
  //probe_id                        = "${azurerm_lb.loadbalancer.id}/probes/${azurerm_lb_probe.k8s_api.name}"
  // KNOWN ISSUE - see README.MD
  // probe_id                    = "${azurerm_lb_probe.ingress_controller.id}}"
  idle_timeout_in_minutes        = 5
  disable_outbound_snat          = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_lb_rule" "additional_ports" {
  count                          = length(local.additional_node_rules_frontend_ports)
  resource_group_name            = var.out_platform_rg_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "AdditionalNodeRule${local.additional_node_rules_frontend_ports[count.index]}to${local.additional_node_rules_backend_ports[count.index]}"
  protocol                       = "Tcp"
  frontend_port                  = local.additional_node_rules_frontend_ports[count.index]
  backend_port                   = local.additional_node_rules_backend_ports[count.index]
  frontend_ip_configuration_name = azurerm_lb.loadbalancer.frontend_ip_configuration.0.name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.nodes.id
  //https://github.com/hashicorp/terraform/issues/9311#issuecomment-254068526
  //probe_id                        = "${azurerm_lb.loadbalancer.id}/probes/${azurerm_lb_probe.additional_node_probes.*.name[count.index]}"
  // KNOWN ISSUE - see README.MD
  // probe_id                    = "${azurerm_lb_probe.ingress_controller.id}}"
  idle_timeout_in_minutes        = 5
  disable_outbound_snat          = false
  load_distribution              = "SourceIPProtocol"
}

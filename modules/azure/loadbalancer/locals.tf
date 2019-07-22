locals {
  additional_node_rules_frontend_ports  = keys(var.loadbalancer_additional_node_loadbalancing_rules)
  additional_node_rules_backend_ports   = values(var.loadbalancer_additional_node_loadbalancing_rules)
}
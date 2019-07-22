output "out_backend_address_pool_masters_id" {
  value       = azurerm_lb_backend_address_pool.masters.id
  description = "ID of the loadblanacer backend address pool that was created for the masters."
}

output "out_backend_address_pool_nodes_id" {
  value       = azurerm_lb_backend_address_pool.nodes.id
  description = "ID of the loadblanacer backend address pool that was created for all nodes."
}

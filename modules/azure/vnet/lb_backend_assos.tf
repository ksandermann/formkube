resource "azurerm_network_interface_backend_address_pool_association" "masters" {
  count                   = var.masters_amount
  network_interface_id    = azurerm_network_interface.masters.*.id[count.index]
  ip_configuration_name   = azurerm_network_interface.masters.*.ip_configuration.0.name[count.index]
  backend_address_pool_id = var.out_backend_address_pool_masters_id
}

resource "azurerm_network_interface_backend_address_pool_association" "computenodes" {
  count                   = var.computenodes_amount
  network_interface_id    = azurerm_network_interface.computenodes.*.id[count.index]
  ip_configuration_name   = azurerm_network_interface.computenodes.*.ip_configuration.0.name[count.index]
  backend_address_pool_id = var.out_backend_address_pool_nodes_id
}

resource "azurerm_network_interface_backend_address_pool_association" "infranodes" {
  count                   = var.infranodes_amount
  network_interface_id    = azurerm_network_interface.infranodes.*.id[count.index]
  ip_configuration_name   = azurerm_network_interface.infranodes.*.ip_configuration.0.name[count.index]
  backend_address_pool_id = var.out_backend_address_pool_nodes_id
}
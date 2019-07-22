#shoutout to https://github.com/terraform-providers/terraform-provider-azurerm/issues/1497#issuecomment-402947551
resource "azurerm_network_interface_application_security_group_association" "bastions" {
  count                         = var.bastions_amount
  network_interface_id          = azurerm_network_interface.bastions.*.id[count.index]
  ip_configuration_name         = azurerm_network_interface.bastions.*.ip_configuration.0.name[count.index]
  application_security_group_id = azurerm_application_security_group.bastions.id
}


resource "azurerm_network_interface_application_security_group_association" "masters" {
  count                         = var.masters_amount
  network_interface_id          = azurerm_network_interface.masters.*.id[count.index]
  ip_configuration_name         = azurerm_network_interface.masters.*.ip_configuration.0.name[count.index]
  application_security_group_id = azurerm_application_security_group.cluster.id
}

resource "azurerm_network_interface_application_security_group_association" "computenodes" {
  count                         = var.computenodes_amount
  network_interface_id          = azurerm_network_interface.computenodes.*.id[count.index]
  ip_configuration_name         = azurerm_network_interface.computenodes.*.ip_configuration.0.name[count.index]
  application_security_group_id = azurerm_application_security_group.cluster.id
}

resource "azurerm_network_interface_application_security_group_association" "infranodes" {
  count                         = var.infranodes_amount
  network_interface_id          = azurerm_network_interface.infranodes.*.id[count.index]
  ip_configuration_name         = azurerm_network_interface.infranodes.*.ip_configuration.0.name[count.index]
  application_security_group_id = azurerm_application_security_group.cluster.id
}


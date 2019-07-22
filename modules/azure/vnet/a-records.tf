resource "azurerm_dns_a_record" "bastions" {
  count               = var.bastions_amount
  name                = "${var.bastions_vm_prefix}${count.index +1}"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  records             = [azurerm_network_interface.bastions.*.ip_configuration.0.private_ip_address[count.index]]
  tags                = var.platform_resource_tags

}

resource "azurerm_dns_a_record" "masters" {
  count               = var.masters_amount
  name                = "${var.masters_vm_prefix}${count.index +1}"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  records             = [azurerm_network_interface.masters.*.ip_configuration.0.private_ip_address[count.index]]
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_a_record" "computenodes" {
  count               = var.computenodes_amount
  name                = "${var.computenodes_vm_prefix}${count.index +1}"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  records             = [azurerm_network_interface.computenodes.*.ip_configuration.0.private_ip_address[count.index]]
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_a_record" "infranodes" {
  count               = var.infranodes_amount
  name                = "${var.infranodes_vm_prefix}${count.index +1}"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  records             = [azurerm_network_interface.infranodes.*.ip_configuration.0.private_ip_address[count.index]]
  tags                = var.platform_resource_tags
}
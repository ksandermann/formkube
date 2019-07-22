resource "azurerm_public_ip" "bastions" {
  count               = var.bastions_amount
  name                = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  ip_version          = "IPv4"
  allocation_method   = "Static"
  tags                = var.platform_resource_tags
  zones               = [(count.index%3)+1]
}
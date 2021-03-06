resource "azurerm_public_ip" "loadbalancer" {
  name                = "${var.loadbalancer_dns_name}.${var.cluster_fqdn}"
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  ip_version          = "IPv4"
  allocation_method   = "Static"
  tags                = var.platform_resource_tags
  sku                 = "Standard"
  //KNOWN ISSUE frontend_ip_configuration.0.zones: attribute supports 1 item maximum, config has 3 declared
  //see KNOWN-ISSUES documentation for more details. (azurerm_lb does not support zone-redundancy)
  //zones                = [1,2,3]
}
resource "azurerm_lb" "loadbalancer" {
  name                    = "${var.loadbalancer_dns_name}.${var.cluster_fqdn}"
  location                = var.platform_location
  resource_group_name     = var.out_platform_rg_name
  //sku is not configurable as Standard SLA for multiple backend pools is always needed
  sku                     = "Standard"
  tags                    = var.platform_resource_tags

  frontend_ip_configuration {
    name                  = "${var.loadbalancer_dns_name}.${var.cluster_fqdn}"
    public_ip_address_id  = azurerm_public_ip.loadbalancer.id
    //KNOWN ISSUE frontend_ip_configuration.0.zones: attribute supports 1 item maximum, config has 3 declared
    //see "sku" part in export template after deploying this "name": "Standard" "tier": "Regional" ?
    //see KNOWN-ISSUES documentation for more details. (azurerm_lb does not support zone-redundancy)
    //zones                = [1,2,3]
  }
}
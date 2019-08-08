resource "azurerm_dns_a_record" "loadbalancer" {
  name                = var.loadbalancer_dns_name
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  //Placeholder - has to be changed after deploying default loadbalancer service with kubectl
  records             = ["10.0.0.1"]
  tags                = var.platform_resource_tags
}
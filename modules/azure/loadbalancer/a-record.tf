resource "azurerm_dns_a_record" "loadbalancer" {
  name                = var.loadbalancer_dns_name
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = 300
  records             = [azurerm_public_ip.loadbalancer.ip_address]
  tags                = var.platform_resource_tags
}
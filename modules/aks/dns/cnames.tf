resource "azurerm_dns_cname_record" "apps" {
  //source
  name                = "apps"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  //target
  record              = "${azurerm_dns_a_record.loadbalancer.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_cname_record" "wildcard_apps" {
  name                = "*.${azurerm_dns_cname_record.apps.name}"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_cname_record.apps.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

//to use with the OpenShift operator framework (monitoring, logging etc.)
resource "azurerm_dns_cname_record" "ops" {
  name                = "ops"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_a_record.loadbalancer.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_cname_record" "ops_default_cnames" {
  count               = length(var.loadbalancer_dns_ops_default_cnames)
  name                = "${var.loadbalancer_dns_ops_default_cnames[count.index]}.ops"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_cname_record.ops.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_cname_record" "ops_additional_cnames" {
  count               = length(var.loadbalancer_dns_ops_additional_cnames)
  name                = "${var.loadbalancer_dns_ops_additional_cnames[count.index]}.ops"
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_cname_record.ops.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_cname_record" "default_cnames" {
  count               = length(var.loadbalancer_dns_default_cnames)
  name                = var.loadbalancer_dns_default_cnames[count.index]
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_a_record.loadbalancer.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}

resource "azurerm_dns_cname_record" "additional_cnames" {
  count               = length(var.loadbalancer_dns_additional_cnames)
  name                = var.loadbalancer_dns_additional_cnames[count.index]
  zone_name           = var.out_platform_dns_zone_name
  resource_group_name = var.out_platform_rg_name
  ttl                 = var.loadbalancer_dns_ttl
  record              = "${azurerm_dns_a_record.loadbalancer.name}.${var.cluster_fqdn}"
  tags                = var.platform_resource_tags
}
resource "azurerm_availability_set" "computenodes" {
  name                          = "${var.computenodes_vm_prefix}s.${var.cluster_fqdn}"
  location                      = var.platform_resource_tags
  resource_group_name           = var.out_platform_rg_name
  managed                       = true
  platform_fault_domain_count   = var.computenodes_fault_domains
  //more than 6 computenodes doesn't make sense
  platform_update_domain_count  = (var.computenodes_fault_domains > 1) ? 6 : 3
  tags                          = var.platform_resource_tags

}

resource "azurerm_availability_set" "infranodes" {
  name                          = "${var.infranodes_vm_prefix}s.${var.cluster_fqdn}"
  location                      = var.platform_resource_tags
  resource_group_name           = var.out_platform_rg_name
  managed                       = true
  platform_fault_domain_count   = var.infranodes_fault_domains
  //more than 6 infranodes doesn't make sense
  platform_update_domain_count  = (var.infranodes_fault_domains > 1) ? 6 : 3
  tags                          = var.platform_resource_tags

}
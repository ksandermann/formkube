resource "azurerm_availability_set" "masters" {
  name                          = "${var.masters_vm_prefix}s.${var.cluster_fqdn}"
  location                      = var.platform_resource_tags
  resource_group_name           = var.out_platform_rg_name
  managed                       = true
  platform_fault_domain_count   = var.masters_fault_domains
  //more than 6 masters doesn't make sense
  platform_update_domain_count  = (var.masters_fault_domains > 1) ? 6 : 3
  tags                          = var.platform_resource_tags

}


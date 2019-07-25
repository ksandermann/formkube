resource "azurerm_availability_set" "bastions" {
  name                          = "${var.bastions_vm_prefix}s.${var.platform_fqdn}"
  location                      = var.platform_location
  resource_group_name           = var.out_platform_rg_name
  managed                       = true
  platform_fault_domain_count   = var.bastions_fault_domains
  platform_update_domain_count  = (var.bastions_fault_domains > 1)  ? 3 : 2
  tags                          = var.cluster_resource_tags

}

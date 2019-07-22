resource "azurerm_recovery_services_vault" "platform" {
  //KNOWNISSUE -> destroying and re-applying this with the same name results in an error message with hint to wait 24hrs -> seems like this
  //is by design in Azure
  count               = local.backup_enabled
  name                = var.backup_vault_name
  // needs to be the same location the vms are residing in
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  sku                 = "Standard"
  tags                = var.platform_resource_tags
}
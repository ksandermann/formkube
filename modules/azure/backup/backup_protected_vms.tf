resource "azurerm_recovery_services_protected_vm" "bastions" {
  count                 = var.bastions_backup_enabled ? var.bastions_amount : 0
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  source_vm_id          = var.out_bastions_vm_ids[count.index]
  backup_policy_id      = azurerm_recovery_services_protection_policy_vm.bastions.*.id[0]
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_protection_policy_vm.bastions, azurerm_recovery_services_vault.platform]

  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}

resource "azurerm_recovery_services_protected_vm" "masters" {
  count                 = var.masters_backup_enabled ? var.masters_amount : 0
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  source_vm_id          = var.out_masters_vm_ids[count.index]
  backup_policy_id      = azurerm_recovery_services_protection_policy_vm.masters.*.id[0]
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_protection_policy_vm.masters, azurerm_recovery_services_vault.platform]

  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}

resource "azurerm_recovery_services_protected_vm" "computenodes" {
  count                 = var.computenodes_backup_enabled ? var.computenodes_amount : 0
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  source_vm_id          = var.out_computenodes_vm_ids[count.index]
  backup_policy_id      = azurerm_recovery_services_protection_policy_vm.computenodes.*.id[0]
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_protection_policy_vm.computenodes, azurerm_recovery_services_vault.platform]

  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}

resource "azurerm_recovery_services_protected_vm" "infranodes" {
  count                 = var.infranodes_backup_enabled ? var.infranodes_amount : 0
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  source_vm_id          = var.out_infranodes_vm_ids[count.index]
  backup_policy_id      = azurerm_recovery_services_protection_policy_vm.infranodes.*.id[0]
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_protection_policy_vm.infranodes, azurerm_recovery_services_vault.platform]

  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}
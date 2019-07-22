resource "azurerm_recovery_services_protection_policy_vm" "bastions" {
  count                 = var.bastions_backup_enabled ? 1 : 0
  name                  = "Backup-${var.bastions_vm_prefix}s"
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  timezone              = var.bastions_backup_timezone
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_vault.platform]

  backup {
    frequency           = var.bastions_backup_frequency
    time                = var.bastions_backup_time
    //only set this when frequency is weekly
    weekdays            = var.bastions_backup_frequency == "Weekly" ? var.bastions_backup_weekdays : null
  }

  //use local list to only set this block if frequency is daily
  dynamic "retention_daily" {
    for_each            = local.bastions_backup_is_daily
    content {
      count             = var.bastions_backup_daily_retentions
    }
  }

  retention_weekly {
    count               = var.bastions_backup_weekly_retentions
    weekdays            = var.bastions_backup_weekly_weekdays
  }

  retention_monthly {
    count               = var.bastions_backup_monthly_retentions
    weekdays            = var.bastions_backup_monthly_weekdays
    weeks               = var.bastions_backup_monthly_weeks
  }

  retention_yearly {
    count               = var.bastions_backup_yearly_retentions
    weekdays            = var.bastions_backup_yearly_weekdays
    weeks               = var.bastions_backup_yearly_weeks
    months              = var.bastions_backup_yearly_months
  }

  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}

resource "azurerm_recovery_services_protection_policy_vm" "masters" {
  count                 = var.masters_backup_enabled ? 1 : 0
  name                  = "Backup-${var.masters_vm_prefix}s"
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  timezone              = var.masters_backup_timezone
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_vault.platform]

  backup {
    frequency           = var.masters_backup_frequency
    time                = var.masters_backup_time
    //only set this when frequency is weekly
    weekdays            = var.masters_backup_frequency == "Weekly" ? var.masters_backup_weekdays : null
  }

  //use local list to only set this block if frequency is daily
  dynamic "retention_daily" {
    for_each            = local.masters_backup_is_daily
    content {
      count             = var.masters_backup_daily_retentions
    }
  }

  retention_weekly {
    count               = var.masters_backup_weekly_retentions
    weekdays            = var.masters_backup_weekly_weekdays
  }

  retention_monthly {
    count               = var.masters_backup_monthly_retentions
    weekdays            = var.masters_backup_monthly_weekdays
    weeks               = var.masters_backup_monthly_weeks
  }

  retention_yearly {
    count               = var.masters_backup_yearly_retentions
    weekdays            = var.masters_backup_yearly_weekdays
    weeks               = var.masters_backup_yearly_weeks
    months              = var.masters_backup_yearly_months
  }
  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}



resource "azurerm_recovery_services_protection_policy_vm" "computenodes" {
  count                 = var.computenodes_backup_enabled ? 1 : 0
  name                  = "Backup-${var.computenodes_vm_prefix}s"
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  timezone              = var.computenodes_backup_timezone
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_vault.platform]

  backup {
    frequency           = var.computenodes_backup_frequency
    time                = var.computenodes_backup_time
    //only set this when frequency is weekly
    weekdays            = var.computenodes_backup_frequency == "Weekly" ? var.computenodes_backup_weekdays : null
  }

  //use local list to only set this block if frequency is daily
  dynamic "retention_daily" {
    for_each            = local.computenodes_backup_is_daily
    content {
      count             = var.computenodes_backup_daily_retentions
    }
  }

  retention_weekly {
    count               = var.computenodes_backup_weekly_retentions
    weekdays            = var.computenodes_backup_weekly_weekdays
  }

  retention_monthly {
    count               = var.computenodes_backup_monthly_retentions
    weekdays            = var.computenodes_backup_monthly_weekdays
    weeks               = var.computenodes_backup_monthly_weeks
  }

  retention_yearly {
    count               = var.computenodes_backup_yearly_retentions
    weekdays            = var.computenodes_backup_yearly_weekdays
    weeks               = var.computenodes_backup_yearly_weeks
    months              = var.computenodes_backup_yearly_months
  }
  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}

resource "azurerm_recovery_services_protection_policy_vm" "infranodes" {
  count                 = var.infranodes_backup_enabled ? 1 : 0
  name                  = "Backup-${var.infranodes_vm_prefix}s"
  resource_group_name   = var.out_platform_rg_name
  recovery_vault_name   = var.backup_vault_name
  timezone              = var.infranodes_backup_timezone
  tags                  = var.platform_resource_tags
  depends_on            = [azurerm_recovery_services_vault.platform]

  backup {
    frequency           = var.infranodes_backup_frequency
    time                = var.infranodes_backup_time
    //only set this when frequency is weekly
    weekdays            = var.infranodes_backup_frequency == "Weekly" ? var.infranodes_backup_weekdays : null
  }

  //use local list to only set this block if frequency is daily
  dynamic "retention_daily" {
    for_each            = local.infranodes_backup_is_daily
    content {
      count             = var.infranodes_backup_daily_retentions
    }
  }

  retention_weekly {
    count               = var.infranodes_backup_weekly_retentions
    weekdays            = var.infranodes_backup_weekly_weekdays
  }

  retention_monthly {
    count               = var.infranodes_backup_monthly_retentions
    weekdays            = var.infranodes_backup_monthly_weekdays
    weeks               = var.infranodes_backup_monthly_weeks
  }

  retention_yearly {
    count               = var.infranodes_backup_yearly_retentions
    weekdays            = var.infranodes_backup_yearly_weekdays
    weeks               = var.infranodes_backup_yearly_weeks
    months              = var.infranodes_backup_yearly_months
  }
  lifecycle {
    //KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
    //and can also not be added to backup targets in Azure portal
    //this workaround prevents this behaviour
    ignore_changes      = [tags]
  }
}
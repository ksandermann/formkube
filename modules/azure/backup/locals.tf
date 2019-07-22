locals {
    backup_enabled                  = (var.bastions_backup_enabled && var.bastions_amount > 0) || (var.masters_backup_enabled && var.masters_amount > 0) || (var.computenodes_backup_enabled && var.computenodes_amount > 0) || (var.infranodes_backup_enabled && var.infranodes_amount > 0) ? 1 : 0
    bastions_backup_is_daily        = var.bastions_backup_frequency == "Daily" ? [true] : []
    masters_backup_is_daily         = var.masters_backup_frequency == "Daily" ? [true] : []
    computenodes_backup_is_daily    = var.computenodes_backup_frequency == "Daily" ? [true] : []
    infranodes_backup_is_daily      = var.infranodes_backup_frequency == "Daily" ? [true] : []
}
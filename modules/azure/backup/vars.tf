/////////////////////////////////////////////////////CLUSTER////////////////////////////////////////////////////////////

variable "backup_vault_name" {
  type = "string"
  description = "Specifies the name of the Recovery Services Vault used for all VMs. Changing this forces a new resource to be created."
}

variable "out_platform_rg_name" {
  type = "string"
  description = "Name of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_location" {
  type = "string"
  description = "Region of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: westeurope"
}

variable "cluster_fqdn" {
  type = "string"
  description = "FQDN of the cluster. Example: k8s-dev.exmaple.com"
}

variable "platform_resource_tags"  {
  type = map(string)
  description = "All tags added to all Azure ressources."
}


/////////////////////////////////////////////////////BASTIONS///////////////////////////////////////////////////////////

variable "bastions_amount" {
  type = "string"
  description = "Number of bastions to create."
}

variable "bastions_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the bastions. Resource name will be build with pattern (bastions_vm_prefix)(index).cluster_name.cluster_domain . Example: bastion"
}

variable "bastions_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the bastions. true = backup enabled"
}

variable "bastions_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the bastions backups. Example: 'UTC'"
}

variable "bastions_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the bastions. Must be either Daily or Weekly."
}

variable "bastions_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
}

variable "bastions_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "bastions_backup_daily_retentions" {
  type = "string"
  description = "The number of daily backups to keep. Must be between 1 and 9999"
}

variable "bastions_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
}

variable "bastions_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "bastions_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
}

variable "bastions_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "bastions_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "bastions_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
}

variable "bastions_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "bastions_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "bastions_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
}

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

variable "masters_amount" {
  type    = "string"
  description = "Number of masters to create."
}

variable "masters_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the masters. Resource name will be build with pattern (masters_vm_prefix)(index).cluster_name.cluster_domain . Example: master"
}

variable "masters_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the masters. true = backup enabled"
}

variable "masters_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the masters backups. Example: 'UTC'"
}

variable "masters_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the masters. Must be either Daily or Weekly."
}

variable "masters_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
}

variable "masters_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "masters_backup_daily_retentions" {
  type = "string"
  description = "The number of daily backups to keep. Must be between 1 and 9999"
}

variable "masters_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
}

variable "masters_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "masters_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
}

variable "masters_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "masters_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "masters_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
}

variable "masters_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "masters_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "masters_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
}

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

variable "computenodes_amount" {
  type    = "string"
  description = "Number of compute nodes to create."
}

variable "computenodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the compute nodes. Resource name will be build with pattern (computenodes_vm_prefix)(index).cluster_name.cluster_domain . Example: computenode"
}

variable "computenodes_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the computenodes. true = backup enabled"
}

variable "computenodes_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the computenodes backups. Example: 'UTC'"
}

variable "computenodes_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the computenodes. Must be either Daily or Weekly."
}

variable "computenodes_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
}

variable "computenodes_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "computenodes_backup_daily_retentions" {
  type = "string"
  description = "The number of daily backups to keep. Must be between 1 and 9999"
}

variable "computenodes_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
}

variable "computenodes_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "computenodes_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
}

variable "computenodes_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "computenodes_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "computenodes_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
}

variable "computenodes_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "computenodes_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "computenodes_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
}

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

variable "infranodes_amount" {
  type    = "string"
  description = "Number of infra nodes to create."
}

variable "infranodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the infra nodes. Resource name will be build with pattern (infranodes_vm_prefix)(index).cluster_name.cluster_domain . Example: infranode"
}

variable "infranodes_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the infranodes. true = backup enabled"
}

variable "infranodes_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the infranodes backups. Example: 'UTC'"
}

variable "infranodes_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the infranodes. Must be either Daily or Weekly."
}

variable "infranodes_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
}

variable "infranodes_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "infranodes_backup_daily_retentions" {
  type = "string"
  description = "The number of daily backups to keep. Must be between 1 and 9999"
}

variable "infranodes_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
}

variable "infranodes_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "infranodes_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
}

variable "infranodes_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "infranodes_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "infranodes_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
}

variable "infranodes_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "infranodes_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
}

variable "infranodes_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_bastions_vm_ids" {
  type = list(string)
  description = "IDs of the bastion VMs that were created."
}

variable "out_masters_vm_ids" {
  type = list(string)
  description = "IDs of the master VMs that were created."
}

variable "out_computenodes_vm_ids" {
  type = list(string)
  description = "IDs of the computenode VMs that were created."
}

variable "out_infranodes_vm_ids" {
  type = list(string)
  description = "IDs of the infranode VMs that were created."
}
terraform {
  required_version = "0.12.4"
}

provider "azurerm" {
  version = "~> 1.31"
}


locals {
  cluster_fqdn = "${var.cluster_name}.${var.cluster_domain}"

  platform_default_resource_tags = {
    "ClusterName" = var.cluster_name,
    "ClusterDomain" = var.cluster_domain,
    "ClusterFQDN" = "${var.cluster_name}.${var.cluster_domain}"
    "ClusterStage" = var.platform_staging_environment
  }

  platform_all_resource_tags = merge(local.platform_default_resource_tags,var.platform_resource_tags_additional)
}

module "essentials" {
  source = "../../modules/azure/essentials"

  //cluster
  platform_rg_name = var.platform_rg_name
  cluster_fqdn = local.cluster_fqdn
  platform_location  = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags

}

module "loadbalancer" {
  source = "../../modules/azure/loadbalancer"

  //cluster
  platform_location  = var.platform_location
  cluster_fqdn = local.cluster_fqdn
  platform_resource_tags = local.platform_all_resource_tags

  //masters
  masters_vm_prefix = var.masters_vm_prefix

  //loadbalancer
  loadbalancer_dns_name = var.loadbalancer_dns_name
  loadbalancer_dns_ttl = var.loadbalancer_dns_ttl

  loadbalancer_dns_additional_cnames = var.loadbalancer_dns_additional_cnames
  loadbalancer_dns_default_cnames = var.loadbalancer_dns_default_cnames
  loadbalancer_dns_ops_additional_cnames = var.loadbalancer_dns_ops_additional_cnames
  loadbalancer_dns_ops_default_cnames = var.loadbalancer_dns_ops_default_cnames

  loadbalancer_ingresscontroller_backend_port = var.loadbalancer_ingresscontroller_backend_port
  loadbalancer_ingresscontroller_frontend_port = var.loadbalancer_ingresscontroller_frontend_port
  loadbalancer_k8s_api_backend_port = var.loadbalancer_k8s_api_backend_port
  loadbalancer_k8s_api_frontend_port = var.loadbalancer_k8s_api_frontend_port
  loadbalancer_additional_node_loadbalancing_rules = var.loadbalancer_additional_node_loadbalancing_rules

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_platform_dns_zone_name = module.essentials.out_platform_dns_zone_name


}

module "vnet" {
  source = "../../modules/azure/vnet"

  //cluster
  cluster_fqdn = local.cluster_fqdn
  platform_location  = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags

  platform_network_CIDRs = var.platform_network_CIDRs
  platform_network_bastion_subnet_CIDR = var.platform_network_bastion_subnet_CIDR
  platform_network_cluster_subnet_CIDR = var.platform_network_cluster_subnet_CIDR


  //bastions
  bastions_amount = var.bastions_amount
  bastions_vm_prefix = var.bastions_vm_prefix

  //masters
  masters_amount = var.masters_amount
  masters_vm_prefix = var.masters_vm_prefix

  //computenodes
  computenodes_amount = var.computenodes_amount
  computenodes_vm_prefix = var.computenodes_vm_prefix

  //infranodes
  infranodes_amount = var.infranodes_amount
  infranodes_vm_prefix = var.infranodes_vm_prefix

  //loadbalancer
  loadbalancer_k8s_api_backend_port = var.loadbalancer_k8s_api_backend_port
  loadbalancer_ingresscontroller_backend_port = var.loadbalancer_ingresscontroller_backend_port
  loadbalancer_additional_node_loadbalancing_rules = var.loadbalancer_additional_node_loadbalancing_rules

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_platform_dns_zone_name = module.essentials.out_platform_dns_zone_name
  out_backend_address_pool_nodes_id = module.loadbalancer.out_backend_address_pool_nodes_id
  out_backend_address_pool_masters_id = module.loadbalancer.out_backend_address_pool_masters_id


}

module "bastions" {
  source = "../../modules/azure/bastions"

  //cluster
  cluster_fqdn = local.cluster_fqdn
  cluster_location  = var.platform_location
  cluster_resource_tags = local.platform_all_resource_tags

  //bastions
  bastions_amount = var.bastions_amount
  bastions_admin_username = var.bastions_admin_username
  bastions_pub_key_controller_path = var.bastions_pub_key_controller_path

  bastions_vm_type = var.bastions_vm_type
  bastions_vm_prefix = var.bastions_vm_prefix

  bastions_os_disk_suffix = var.bastions_os_disk_suffix
  bastions_os_disk_type = var.bastions_os_disk_type
  bastions_os_disk_size_gb = var.bastions_os_disk_size_gb

  bastions_os_image_offer = var.bastions_os_image_offer
  bastions_os_image_publisher = var.bastions_os_image_publisher
  bastions_os_image_sku = var.bastions_os_image_sku
  bastions_os_image_version = var.bastions_os_image_version

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_bastions_subnet_nics_ids = module.vnet.out_bastions_nics_ids

  bastion_vhd_uri = module.essentials.out_vhd_uri
}

module "masters" {
  source = "../../modules/azure/masters"

  //cluster
  cluster_fqdn = local.cluster_fqdn
  platform_location  = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags

  //masters
  masters_amount = var.masters_amount
  masters_vm_type = var.masters_vm_type
  masters_vm_prefix = var.masters_vm_prefix
  masters_os_disk_suffix = var.masters_os_disk_suffix
  masters_admin_username = var.masters_admin_username
  masters_os_disk_size_gb = var.masters_os_disk_size_gb
  masters_pub_key_controller_path = var.masters_pub_key_controller_path
  masters_os_disk_type = var.masters_os_disk_type
  masters_os_image_offer = var.masters_os_image_offer
  masters_os_image_publisher = var.masters_os_image_publisher
  masters_os_image_sku = var.masters_os_image_sku
  masters_os_image_version = var.masters_os_image_version
  masters_os_disk_delete_on_destroy = var.masters_os_disk_delete_on_destroy

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_masters_nics_ids = module.vnet.out_masters_nics_ids

}

module "nodes" {
  source = "../../modules/azure//nodes"

  //cluster
  cluster_fqdn = local.cluster_fqdn
  platform_location  = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags

  //computenodes
  computenodes_amount = var.computenodes_amount
  computenodes_vm_type = var.computenodes_vm_type
  computenodes_vm_prefix = var.computenodes_vm_prefix
  computenodes_os_disk_suffix = var.computenodes_os_disk_suffix
  computenodes_admin_username = var.computenodes_admin_username
  computenodes_os_disk_size_gb = var.computenodes_os_disk_size_gb
  computenodes_pub_key_controller_path = var.computenodes_pub_key_controller_path
  computenodes_os_disk_type = var.computenodes_os_disk_type
  computenodes_os_image_offer = var.computenodes_os_image_offer
  computenodes_os_image_publisher = var.computenodes_os_image_publisher
  computenodes_os_image_sku = var.computenodes_os_image_sku
  computenodes_os_image_version = var.computenodes_os_image_version


  //infranodes
  infranodes_amount = var.infranodes_amount
  infranodes_vm_type = var.infranodes_vm_type
  infranodes_vm_prefix = var.infranodes_vm_prefix
  infranodes_os_disk_suffix = var.infranodes_os_disk_suffix
  infranodes_admin_username = var.infranodes_admin_username
  infranodes_os_disk_size_gb = var.infranodes_os_disk_size_gb
  infranodes_pub_key_controller_path = var.infranodes_pub_key_controller_path
  infranodes_os_disk_type = var.infranodes_os_disk_type
  infranodes_os_image_offer = var.infranodes_os_image_offer
  infranodes_os_image_publisher = var.infranodes_os_image_publisher
  infranodes_os_image_sku = var.infranodes_os_image_sku
  infranodes_os_image_version = var.infranodes_os_image_version

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_computenodes_nics_ids = module.vnet.out_computenodes_nics_ids
  out_infranodes_nics_ids = module.vnet.out_infranodes_nics_ids

}

module "backup" {
  source = "../../modules/azure/backup"

  //cluster
  backup_vault_name = var.backup_vault_name
  cluster_fqdn = local.cluster_fqdn
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags

  //bastions
  bastions_amount = var.bastions_amount
  bastions_vm_prefix = var.bastions_vm_prefix
  bastions_backup_daily_retentions = var.bastions_backup_daily_retentions
  bastions_backup_enabled = var.bastions_backup_enabled
  bastions_backup_frequency = var.bastions_backup_frequency
  bastions_backup_monthly_retentions = var.bastions_backup_monthly_retentions
  bastions_backup_monthly_weekdays = var.bastions_backup_monthly_weekdays
  bastions_backup_monthly_weeks = var.bastions_backup_monthly_weeks
  bastions_backup_time = var.bastions_backup_time
  bastions_backup_timezone = var.bastions_backup_timezone
  bastions_backup_weekdays = var.bastions_backup_weekdays
  bastions_backup_weekly_retentions = var.bastions_backup_weekly_retentions
  bastions_backup_weekly_weekdays = var.bastions_backup_weekly_weekdays
  bastions_backup_yearly_months = var.bastions_backup_yearly_months
  bastions_backup_yearly_retentions = var.bastions_backup_yearly_retentions
  bastions_backup_yearly_weekdays = var.bastions_backup_yearly_weekdays
  bastions_backup_yearly_weeks = var.bastions_backup_yearly_weeks

  //masters
  masters_amount = var.masters_amount
  masters_vm_prefix = var.masters_vm_prefix
  masters_backup_daily_retentions = var.masters_backup_daily_retentions
  masters_backup_enabled = var.masters_backup_enabled
  masters_backup_frequency = var.masters_backup_frequency
  masters_backup_monthly_retentions = var.masters_backup_monthly_retentions
  masters_backup_monthly_weekdays = var.masters_backup_monthly_weekdays
  masters_backup_monthly_weeks = var.masters_backup_monthly_weeks
  masters_backup_time = var.masters_backup_time
  masters_backup_timezone = var.masters_backup_timezone
  masters_backup_weekdays = var.masters_backup_weekdays
  masters_backup_weekly_retentions = var.masters_backup_weekly_retentions
  masters_backup_weekly_weekdays = var.masters_backup_weekly_weekdays
  masters_backup_yearly_months = var.masters_backup_yearly_months
  masters_backup_yearly_retentions = var.masters_backup_yearly_retentions
  masters_backup_yearly_weekdays = var.masters_backup_yearly_weekdays
  masters_backup_yearly_weeks = var.masters_backup_yearly_weeks

  //computenodes
  computenodes_amount = var.computenodes_amount
  computenodes_vm_prefix = var.computenodes_vm_prefix
  computenodes_backup_daily_retentions = var.computenodes_backup_daily_retentions
  computenodes_backup_enabled = var.computenodes_backup_enabled
  computenodes_backup_frequency = var.computenodes_backup_frequency
  computenodes_backup_monthly_retentions = var.computenodes_backup_monthly_retentions
  computenodes_backup_monthly_weekdays = var.computenodes_backup_monthly_weekdays
  computenodes_backup_monthly_weeks = var.computenodes_backup_monthly_weeks
  computenodes_backup_time = var.computenodes_backup_time
  computenodes_backup_timezone = var.computenodes_backup_timezone
  computenodes_backup_weekdays = var.computenodes_backup_weekdays
  computenodes_backup_weekly_retentions = var.computenodes_backup_weekly_retentions
  computenodes_backup_weekly_weekdays = var.computenodes_backup_weekly_weekdays
  computenodes_backup_yearly_months = var.computenodes_backup_yearly_months
  computenodes_backup_yearly_retentions = var.computenodes_backup_yearly_retentions
  computenodes_backup_yearly_weekdays = var.computenodes_backup_yearly_weekdays
  computenodes_backup_yearly_weeks = var.computenodes_backup_yearly_weeks

  //infranodes
  infranodes_amount = var.infranodes_amount
  infranodes_vm_prefix = var.infranodes_vm_prefix
  infranodes_backup_daily_retentions = var.infranodes_backup_daily_retentions
  infranodes_backup_enabled = var.infranodes_backup_enabled
  infranodes_backup_frequency = var.infranodes_backup_frequency
  infranodes_backup_monthly_retentions = var.infranodes_backup_monthly_retentions
  infranodes_backup_monthly_weekdays = var.infranodes_backup_monthly_weekdays
  infranodes_backup_monthly_weeks = var.infranodes_backup_monthly_weeks
  infranodes_backup_time = var.infranodes_backup_time
  infranodes_backup_timezone = var.infranodes_backup_timezone
  infranodes_backup_weekdays = var.infranodes_backup_weekdays
  infranodes_backup_weekly_retentions = var.infranodes_backup_weekly_retentions
  infranodes_backup_weekly_weekdays = var.infranodes_backup_weekly_weekdays
  infranodes_backup_yearly_months = var.infranodes_backup_yearly_months
  infranodes_backup_yearly_retentions = var.infranodes_backup_yearly_retentions
  infranodes_backup_yearly_weekdays = var.infranodes_backup_yearly_weekdays
  infranodes_backup_yearly_weeks = var.infranodes_backup_yearly_weeks

  //dependencies
  out_platform_rg_name = module.essentials.out_platform_rg_name
  out_bastions_vm_ids = module.bastions.out_bastions_vm_ids
  out_masters_vm_ids = module.masters.out_masters_vm_ids
  out_computenodes_vm_ids = module.nodes.out_computenodes_vm_ids
  out_infranodes_vm_ids = module.nodes.out_infranodes_vm_ids

}
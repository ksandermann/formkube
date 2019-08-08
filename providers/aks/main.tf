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

  cluster_k8s_serviceaccount_client_id = "79435f73-3a29-4a51-966a-8ec3d579cab0"
  cluster_k8s_serviceaccount_client_secret = "a20be318-dd1d-451e-97df-90d622454f98"
}


module "essentials" {
  source = "../../modules/aks/essentials"
  platform_fqdn = local.cluster_fqdn
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
  platform_rg_name = var.platform_rg_name
}


module "vnet" {
  source = "../../modules/aks/vnet"
  out_platform_rg_name = module.essentials.out_platform_rg_name
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
  cluster_fqdn = local.cluster_fqdn
}

module "cluster" {
  source = "../../modules/aks/cluster"
  cluster_domain = var.cluster_domain
  cluster_k8s_serviceaccount_client_id = local.cluster_k8s_serviceaccount_client_id
  cluster_k8s_serviceaccount_client_secret = local.cluster_k8s_serviceaccount_client_secret
  cluster_name = var.cluster_name
  computenodes_admin_username = var.computenodes_admin_username
  computenodes_amount = var.computenodes_amount
  computenodes_os_disk_size_gb = var.computenodes_os_disk_size_gb
  computenodes_pub_key_controller_path = var.computenodes_pub_key_controller_path
  computenodes_vm_prefix = var.computenodes_vm_prefix
  computenodes_vm_type = var.computenodes_vm_type
  infranodes_amount = var.infranodes_amount
  infranodes_os_disk_size_gb = var.infranodes_os_disk_size_gb
  infranodes_vm_prefix = var.infranodes_vm_prefix
  infranodes_vm_type = var.infranodes_vm_type
  out_cluster_subnet_id = module.vnet.out_cluster_subnet_id
  out_log_analytics_workspace_id = module.essentials.out_log_analytics_workspace_id
  out_platform_rg_name = module.essentials.out_platform_rg_name
  platform_fqdn = local.cluster_fqdn
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
}
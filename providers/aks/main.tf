terraform {
  required_version = "0.12.6"
}

provider "azurerm" {
  version = "~> 1.32.1"
}

provider "azuread" {
  version = "~> 0.5.1"
}

provider "random" {
  version = "~> 2.2"
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
  source = "../../modules/aks/essentials"
  platform_fqdn = local.cluster_fqdn
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
  platform_rg_name = var.platform_rg_name
}

//todo: re-enable this when terraform supported granting admin consent
//module "aad" {
//  source = "../../modules/aks/aad"
//
//  aks_cluster_k8s_ad_server_app_secret = var.aks_cluster_k8s_ad_server_app_secret
//  platform_fqdn = local.cluster_fqdn
//
//}

module "dns" {
  source = "../../modules/aks/dns"

  cluster_fqdn = local.cluster_fqdn
  loadbalancer_dns_additional_cnames = var.loadbalancer_dns_additional_cnames
  loadbalancer_dns_default_cnames = var.loadbalancer_dns_default_cnames
  loadbalancer_dns_name = var.loadbalancer_dns_name
  loadbalancer_dns_ops_additional_cnames = var.loadbalancer_dns_ops_additional_cnames
  loadbalancer_dns_ops_default_cnames = var.loadbalancer_dns_ops_default_cnames
  loadbalancer_dns_ttl = var.loadbalancer_dns_ttl
  out_platform_dns_zone_name = module.essentials.out_platform_dns_zone_name
  out_platform_rg_name = module.essentials.out_platform_rg_name
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
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


  //infranodes are not supported when using AKS provider
  cluster_domain = var.cluster_domain
  aks_cluster_k8s_serviceaccount_client_id = var.aks_cluster_k8s_serviceaccount_client_id
  aks_cluster_k8s_serviceaccount_client_secret = var.aks_cluster_k8s_serviceaccount_client_secret
  cluster_name = var.cluster_name
  out_cluster_subnet_id = module.vnet.out_cluster_subnet_id
  out_log_analytics_workspace_id = module.essentials.out_log_analytics_workspace_id
  out_platform_rg_name = module.essentials.out_platform_rg_name
  platform_fqdn = local.cluster_fqdn
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
  aks_cluster_k8s_version = var.aks_cluster_k8s_version
  aks_nodes_admin_username = var.aks_nodes_admin_username
  aks_nodes_amount = var.aks_nodes_amount
  aks_nodes_max_pods = var.aks_nodes_max_pods
  aks_nodes_os_disk_size_gb = var.aks_nodes_os_disk_size_gb
  aks_nodes_pub_key_controller_path = var.aks_nodes_pub_key_controller_path
  aks_nodes_vm_prefix = var.aks_nodes_vm_prefix
  aks_nodes_vm_type = var.aks_nodes_vm_type

  aks_cluster_k8s_ad_client_app_id = var.aks_cluster_k8s_ad_client_app_id
  aks_cluster_k8s_ad_server_app_id = var.aks_cluster_k8s_ad_server_app_id
  aks_cluster_k8s_ad_server_app_secret = var.aks_cluster_k8s_ad_server_app_secret
}
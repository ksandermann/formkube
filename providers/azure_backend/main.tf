terraform {
  required_version = "0.12.9"
}

provider "azurerm" {
  version = "~> 1.33.1"
}

locals {
  cluster_fqdn = "${var.cluster_name}.${var.cluster_domain}"

  platform_default_resource_tags  = {
    "ClusterName"     = var.cluster_name,
    "ClusterDomain"   = var.cluster_domain,
    "ClusterFQDN"     = "${var.cluster_name}.${var.cluster_domain}"
    "ClusterStage"    = var.platform_staging_environment
  }

  platform_all_resource_tags = merge(local.platform_default_resource_tags,var.platform_resource_tags_additional)
}

module "azure_backend" {
  source                  = "../../modules/azure_backend"

  backend_resourcegroup_name = var.backend_resourcegroup_name
  backend_storageaccount_name = var.backend_storageaccount_name
  backend_storagecontainer_name = var.backend_storagecontainer_name
  platform_location = var.platform_location
  platform_resource_tags = local.platform_all_resource_tags
}

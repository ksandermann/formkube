variable "backend_resourcegroup_name" {
  type        = "string"
  description = "Name of the resource group to create for the backend storage account."
}

variable "backend_storageaccount_name" {
  type        = "string"
  description = "Name of the backend storage account."
}

variable "backend_storagecontainer_name" {
  type        = "string"
  description = "Name of the backend storage container."
}


variable "platform_location" {
  type        = "string"
  description = "Region of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: westeurope"
}

variable "cluster_name" {
  type = "string"
  description = "Name of the cluster. This is NOT the FQDN, cluster will be named cluster_name.cluster_domain. Example: k8s-dev"
}

variable "cluster_domain" {
  type = "string"
  description = "domain of the cluster. No leading '.' needed. Example: example.com"
}

variable "platform_staging_environment"  {
  type = "string"
  description = "Stage of the platform."
  default = "dev"
}

variable "platform_resource_tags_additional"  {
  type = map(string)
  description = "Additional tags added to all Azure ressources. Default values are ClusterName, ClusterDomain and ClusterFQDN."
  default = {}
}

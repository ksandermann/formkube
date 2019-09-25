variable "state_rg_name" {
  type        = "string"
  description = "Name of the resource group to create for the backend storage account."
}

variable "platform_location" {
  type        = "string"
  description = "Region of the resource group to create for the backend storage account."
}

variable "cluster_fqdn" {
  type        = "string"
  description = "FQDN of the cluster. Example: k8s-dev.exmaple.com"
}

variable "platform_resource_tags"  {
  type        = map(string)
  description = "All tags added to all Azure ressources."
}

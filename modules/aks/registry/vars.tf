variable "out_platform_rg_name" {
  type        = "string"
  description = "Name of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_fqdn" {
  type = "string"
  description = "FQDN of the cluster. Example: k8s-dev.exmaple.com"
}

variable "platform_location" {
  type        = "string"
  description = "Region of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: westeurope"
}

variable "platform_resource_tags"  {
  type        = map(string)
  description = "All tags added to all Azure ressources."
}

variable "registry_sku" {
  type        = "string"
  default     = "Premium"
  description = "The SKU name of the the container registry. Possible values are Basic, Standard and Premium."
}

variable "registry_georeplication_locations" {
  type        = array(string)
  default     = []
  description = "A list of Azure locations where the container registry should be geo-replicated. Example: ['East US']"
}

variable "registry_admin_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the admin user is enabled."
}

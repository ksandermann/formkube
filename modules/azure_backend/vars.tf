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
  description = "Region of the resource group to create for the backend storage account."
}
variable "platform_resource_tags"  {
  type        = map(string)
  description = "All tags added to all Azure ressources."
}

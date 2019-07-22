/////////////////////////////////////////////////////CLUSTER////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

variable "masters_amount" {
  type    = "string"
  description = "Number of masters to create."
}

variable "masters_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the masters. Resource name will be build with pattern (masters_vm_prefix)(index).cluster_name.cluster_domain . Example: master"
}

variable "masters_vm_type" {
  type = "string"
  description = "Type of the vm for the master. Example: Standard_DS1_v2"
}

variable "masters_os_disk_delete_on_destroy" {
  type = bool
  description = "Configures if the os disk of the masters should be deleted when deleting the vm, i.e. with terraform destroy"
}

variable "masters_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disk of the master. Resource name will be build with pattern master.cluster_name.cluster_domain-master_os_disk_suffix . Example: system"
}

variable "masters_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disk for the master. Example: 30"
}

variable "masters_admin_username" {
  type = "string"
  description = "Name of the admin user on the master. Example: admin"
}

variable "masters_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the master."
}

variable "masters_os_disk_type" {
  type = "string"
  description = "Disk type of the os disk of the master. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
}

variable "masters_os_image_publisher" {
  type = "string"
  description = "Image publisher for the master OS. Only Linux supported. Example: Canonical"
}

variable "masters_os_image_offer" {
  type = "string"
  description = "Image offer for the master OS. Only Linux supported. Example: UbuntuServer"
}

variable "masters_os_image_sku" {
  type = "string"
  description = "Image sku for the master OS. Only Linux supported. Example: 18.04-LTS"
}

variable "masters_os_image_version" {
  type = "string"
  description = "Image version for the master OS. Only Linux supported. Example: latest"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_masters_nics_ids" {
  type = list(string)
  description = "IDs of the NICs created for the masters."
}

variable "platform_resource_tags"  {
  type = map(string)
  description = "All tags added to all Azure ressources."
}
/////////////////////////////////////////////////////CLUSTER////////////////////////////////////////////////////////////

variable "out_platform_rg_name" {
  type = "string"
  description = "Name of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_location" {
  type = "string"
  description = "Region of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: westeurope"
}

variable "platform_fqdn" {
  type = "string"
  description = "FQDN of the cluster. Example: k8s-dev.example.com"
}

/////////////////////////////////////////////////////BASTIONS///////////////////////////////////////////////////////////

variable "bastions_amount" {
  type = "string"
  description = "Number of bastions to create."
}

variable "bastions_fault_domains" {
  type = "string"
  description = "Number of fault domains for the availibility set of the bastions. This is depending on the region that you are using. https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md"
}

variable "bastions_vm_type" {
  type = "string"
  description = "Type of the vm for the bastion. Example: Standard_DS1_v2"
}

variable "bastions_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the bastions. Resource name will be build with pattern (bastions_vm_prefix)(index).cluster_name.cluster_domain . Example: bastion"
}

variable "bastions_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disk of the bastion. Resource name will be build with pattern bastion.cluster_name.cluster_domain-bastion_os_disk_suffix . Example: system"
}

variable "bastions_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disk for the bastion. Example: 30"
}

variable "bastions_admin_username" {
  type = "string"
  description = "Name of the admin user on the bastion. Example: admin"
}

variable "bastions_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the bastion."
}

variable "bastions_os_disk_type" {
  type = "string"
  description = "Disk type of the os disk of the bastion. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
}

variable "bastions_os_image_publisher" {
  type = "string"
  description = "Image publisher for the bastion OS. Only Linux supported. Example: Canonical"
}

variable "bastions_os_image_offer" {
  type = "string"
  description = "Image offer for the bastion OS. Only Linux supported. Example: UbuntuServer"
}

variable "bastions_os_image_sku" {
  type = "string"
  description = "Image sku for the bastion OS. Only Linux supported. Example: 18.04-LTS"
}

variable "bastions_os_image_version" {
  type = "string"
  description = "Image version for the bastion OS. Only Linux supported. Example: latest"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_bastions_subnet_nics_ids" {
  type = list(string)
  description = "IDs of the private NICs created for the bastions."
}

variable "cluster_resource_tags"  {
  type = map(string)
  description = "All tags added to all Azure ressources."
}
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

variable "platform_resource_tags"  {
  type = map(string)
  description = "All tags added to all Azure ressources."
}


/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

variable "computenodes_amount" {
  type    = "string"
  description = "Number of compute nodes to create."
}

variable "computenodes_fault_domains" {
  type = "string"
  description = "Number of fault domains for the availibility set of the computenodes. This is depending on the region that you are using. https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md"
}

variable "computenodes_vm_type" {
  type = "string"
  description = "Type of the vm for the compute nodes. Example: Standard_DS1_v2"
}

variable "computenodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the compute nodes. Resource name will be build with pattern (computenodes_vm_prefix)(index).cluster_name.cluster_domain . Example: computenode"
}

variable "computenodes_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disks of the compute nodes. Resource name will be build with pattern node.cluster_name.cluster_domain-node_os_disk_suffix . Example: system"
}

variable "computenodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the compute nodes. Example: 30"
}

variable "computenodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the compute nodes. Example: admin"
}

variable "computenodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the compute nodes."
}

variable "computenodes_os_disk_type" {
  type = "string"
  description = "Disk type of the os disks of the compute nodes. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
}

variable "computenodes_os_image_publisher" {
  type = "string"
  description = "Image publisher for the compute nodes OS. Only Linux supported. Example: Canonical"
}

variable "computenodes_os_image_offer" {
  type = "string"
  description = "Image offer for the compute nodes OS. Only Linux supported. Example: UbuntuServer"
}

variable "computenodes_os_image_sku" {
  type = "string"
  description = "Image sku for the compute nodes OS. Only Linux supported. Example: 18.04-LTS"
}

variable "computenodes_os_image_version" {
  type = "string"
  description = "Image version for the compute nodes OS. Only Linux supported. Example: latest"
}

/////////////////////////////////////////////////////INFRANDOES/////////////////////////////////////////////////////////

variable "infranodes_amount" {
  type    = "string"
  description = "Number of infra nodes to create."
}

variable "infranodes_fault_domains" {
  type = "string"
  description = "Number of fault domains for the availibility set of the infranodes. This is depending on the region that you are using. https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md"
}

variable "infranodes_vm_type" {
  type = "string"
  description = "Type of the vm for the infra nodes. Example: Standard_DS1_v2"
}

variable "infranodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the infra nodes. Resource name will be build with pattern (infranodes_vm_prefix)(index).cluster_name.cluster_domain . Example: infranode"
}

variable "infranodes_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disks of the infra nodes. Resource name will be build with pattern node.cluster_name.cluster_domain-node_os_disk_suffix . Example: system"
}

variable "infranodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the infra nodes. Example: 30"
}

variable "infranodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the infra nodes. Example: admin"
}

variable "infranodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the infra nodes."
}

variable "infranodes_os_disk_type" {
  type = "string"
  description = "Disk type of the os disks of the infra nodes. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
}

variable "infranodes_os_image_publisher" {
  type = "string"
  description = "Image publisher for the infra nodes OS. Only Linux supported. Example: Canonical"
}

variable "infranodes_os_image_offer" {
  type = "string"
  description = "Image offer for the infra nodes OS. Only Linux supported. Example: UbuntuServer"
}

variable "infranodes_os_image_sku" {
  type = "string"
  description = "Image sku for the infra nodes OS. Only Linux supported. Example: 18.04-LTS"
}

variable "infranodes_os_image_version" {
  type = "string"
  description = "Image version for the infra nodes OS. Only Linux supported. Example: latest"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_computenodes_nics_ids" {
  type = list(string)
  description = "IDs of the NICs created for the compute nodes."
}

variable "out_infranodes_nics_ids" {
  type = list(string)
  description = "IDs of the NICs created for the infra nodes."
}
variable "platform_rg_name" {
  type = "string"
  description = "Name of the resource group to create for the platform. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_location" {
  type = "string"
  description = "Region of the resource group to create for the platform. It is recommended to not use an existing rg. Example: westeurope"
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
}






//////optional

variable "platform_resource_tags_additional"  {
  type = map(string)
  description = "Additional tags added to all Azure ressources. Default values are ClusterName, ClusterDomain and ClusterFQDN."
  default = {}
}


/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

variable "computenodes_amount" {
  type    = "string"
  description = "Number of compute nodes to create."
}

variable "computenodes_vm_type" {
  type = "string"
  description = "Type of the vm for the compute nodes. Example: Standard_D8_v3"
}

variable "computenodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the compute nodes. Resource name will be build with pattern (computenodes_vm_prefix)(index).cluster_name.cluster_domain . Example: computenode"
}

variable "computenodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the compute nodes. Example: 200"
}

variable "computenodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the compute nodes."
}

variable "computenodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the compute nodes. Must not be admin or root Example: operator"
}

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

variable "infranodes_amount" {
  type    = "string"
  description = "Number of infra nodes to create."
}

variable "infranodes_vm_type" {
  type = "string"
  description = "Type of the vm for the infra nodes. Example: Standard_D8_v3"
}

variable "infranodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the infra nodes. Resource name will be build with pattern (infranodes_vm_prefix)(index).cluster_name.cluster_domain . Example: infranode"
}

variable "infranodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the infra nodes. Example: 200"
}




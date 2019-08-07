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

variable "platform_resource_tags"  {
  type = map(string)
  description = "All tags added to all Azure ressources."
}

variable "cluster_name" {
  type = "string"
  description = "Name of the cluster. This is NOT the FQDN, cluster will be named cluster_name.cluster_domain. Example: k8s-dev"
}

variable "cluster_domain" {
  type = "string"
  description = "domain of the cluster. No leading '.' needed. Example: example.com"
}

variable "cluster_k8s_serviceaccount_client_id" {
  type = "string"
  description = "ClientID of the Service Principal Used for the Kubernetes Cloud Provider"
}

variable "cluster_k8s_serviceaccount_client_secret" {
  type = "string"
  description = "ClientSecret of the Service Principal Used for the Kubernetes Cloud Provider"
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









variable "out_log_analytics_workspace_id" {
  type = "string"
  description = "ID of the Log Analytics Workspace that was created."
}
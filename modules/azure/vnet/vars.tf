/////////////////////////////////////////////////////CLUSTER////////////////////////////////////////////////////////////

variable "out_platform_rg_name" {
  type        = "string"
  description = "Name of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_location" {
  type        = "string"
  description = "Region of the resource group to create for the cluster. It is recommended to not use an existing rg. Example: westeurope"
}

variable "cluster_fqdn" {
  type        = "string"
  description = "FQDN of the cluster. Example: k8s-dev.exmaple.com"
}

variable "platform_resource_tags"  {
  type        = map(string)
  description = "All tags added to all Azure ressources."
}

variable "platform_network_CIDRs" {
  type        = list(string)
  description = "CIDRs of the whole network for the cluster (Masters, Nodes and Bastion). Do NOT change this after initial deployment."
}

variable "platform_network_bastion_subnet_CIDR" {
  type        = "string"
  description = "CIDRs of the subnet for the bastion. Has to be a subset of the CIDRs defined in cluster_network_CIDRs . Do NOT change this after initial deployment."
}

variable "platform_network_cluster_subnet_CIDR" {
  type        = "string"
  description = "CIDRs of the subnet for the cluster (Masters and Nodes). Has to be a subset of the CIDRs defined in cluster_network_CIDRs . Do NOT change this after initial deployment."
}

/////////////////////////////////////////////////////LOADBALANCER///////////////////////////////////////////////////////

variable "loadbalancer_k8s_api_backend_port" {
  type       = "string"
  description = "Backend port on the Masters where the k8s API will be running."
}

variable "loadbalancer_ingresscontroller_backend_port" {
  type       = "string"
  description = "Backend port on all nodes where the default ingresscontroller will be running. All Nodes (infra and compute) will be added to the Loadbalancer rule. If the lb doesnt reach the ingresscontroller on compute nodes, they will be automatically marked as unreachable and won't be considered for loadbalancing anymore."
}

variable "loadbalancer_additional_node_loadbalancing_rules"  {
  type = map(string)
  description = "Additional loadbalancing rules for the nodes. Will be created for both UDP and TCP as protocols. Example: { '80' = '31080' }"
}


/////////////////////////////////////////////////////BASTIONS///////////////////////////////////////////////////////////

variable "bastions_amount" {
  type        = "string"
  description = "Number of bastions to create."
}
variable "bastions_vm_prefix" {
  type        = "string"
  description = "Prefix of the name of the vm resource for the bastions. Resource name will be build with pattern (bastions_vm_prefix)(index).cluster_name.cluster_domain . Example: bastion"
}

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

variable "masters_amount" {
  type        = "string"
  description = "Number of masters to create."
}

variable "masters_vm_prefix" {
  type        = "string"
  description = "Prefix of the name of the vm resource for the masters. Resource name will be build with pattern (masters_vm_prefix)(index).cluster_name.cluster_domain . Example: master"
}

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

variable "computenodes_amount" {
  type        = "string"
  description = "Number of compute nodes to create."
}

variable "computenodes_vm_prefix" {
  type        = "string"
  description = "Prefix of the name of the vm resource for the compute nodes. Resource name will be build with pattern (computenodes_vm_prefix)(index).cluster_name.cluster_domain . Example: computenode"
}

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

variable "infranodes_amount" {
  type        = "string"
  description = "Number of infra nodes to create."
}

variable "infranodes_vm_prefix" {
  type        = "string"
  description = "Prefix of the name of the vm resource for the infra nodes. Resource name will be build with pattern (infranodes_vm_prefix)(index).cluster_name.cluster_domain . Example: infranode"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_platform_dns_zone_name" {
  type        = "string"
  description = "Name of the dns zone that was created."
}

variable "out_backend_address_pool_masters_id" {
  type        = "string"
  description = "ID of the loadbalancer backend address pool that was created for the masters."
}

variable "out_backend_address_pool_nodes_id" {
  type        = "string"
  description = "ID of the loadbalancer backend address pool that was created all nodes."
}
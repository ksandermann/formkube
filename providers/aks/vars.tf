////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////MANDATORY//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

variable "aks_nodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the compute aks_nodes."
}

variable "aks_cluster_k8s_serviceaccount_client_id" {
  type = "string"
  description = "ClientID of the Service Principal Used for the Kubernetes Cloud Provider"
}

variable "aks_cluster_k8s_serviceaccount_client_secret" {
  type = "string"
  description = "ClientSecret of the Service Principal Used for the Kubernetes Cloud Provider"
}

variable "aks_cluster_k8s_version" {
  type = "string"
  description = "Kubernetes Version of the AKS cluster."
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////OPTIONAL///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////PLATFORM///////////////////////////////////////////////////////////

variable "platform_resource_tags_additional"  {
  type = map(string)
  description = "Additional tags added to all Azure ressources. Default values are ClusterName, ClusterDomain and ClusterFQDN."
  default = {}
}


/////////////////////////////////////////////////////LOADBALANCER/DNS///////////////////////////////////////////////////

variable "loadbalancer_dns_name" {
  type = "string"
  description = "Name of the loadbalancer. This will be used for DNS entries and ressource names. Example: alb"
  default = "alb"
}

variable "loadbalancer_dns_ttl" {
  type = "string"
  description = "TTL (in seconds) for DNS records for the loadbalancer."
  default = "300"
}

variable "loadbalancer_dns_default_cnames" {
  type = list(string)
  description = "Default CNAME records for the loadbalancer. Example: ['cluster', 'logs', 'elastic', 'kibana', 'hawkular-metrics', 'registry', 'dashboard']"
  default = ["api","cluster", "logs", "elastic", "kibana", "hawkular-metrics", "registry", "dashboard"]
}

variable "loadbalancer_dns_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['grafana', 'prometheus', 'console']"
  default = []
}

variable "loadbalancer_dns_ops_default_cnames" {
  type = list(string)
  description = "Default CNAME records for .ops.loadbalancer_name.cluster_name.cluster_domain To use with the OpenShift operator paradigm (see: https://docs.okd.io/3.11/install_config/prometheus_cluster_monitoring.html//configuring-openshift-cluster-monitoring). Example: ['kibana', 'elastic', 'grafana', 'prometheus']"
  default = ["kibana", "elastic", "grafana", "prometheus"]
}

variable "loadbalancer_dns_ops_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_ops_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['sentinel']"
  default = []
}

/////////////////////////////////////////////////////AKS-NODES//////////////////////////////////////////////////////////


variable "aks_nodes_amount" {
  type    = "string"
  description = "Number of compute aks_nodes to create."
  default = "3"
}

variable "aks_nodes_vm_type" {
  type = "string"
  description = "Type of the vm for the compute aks_nodes. Example: Standard_D8_v3"
  default = "Standard_D8_v3"
}

variable "aks_nodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the aks nodes. Resource name will be build with pattern (aks_nodes_vm_prefix)(index).cluster_name.cluster_domain . Example: linuxnode"
  default = "node"
}

variable "aks_nodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the compute aks_nodes. Example: 200"
  default = "200"
}

variable "aks_nodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the compute aks_nodes. Must not be admin or root Example: clusteradmin"
  default = "clusteradmin"
}

variable "aks_nodes_max_pods" {
  type = "string"
  description = "Maximum number of pods that can run on a single node. Example: 100"
  default =  "100"
}

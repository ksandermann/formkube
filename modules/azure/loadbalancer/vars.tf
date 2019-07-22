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

/////////////////////////////////////////////////////LOADBALANCER///////////////////////////////////////////////////////

variable "loadbalancer_dns_name" {
  type = "string"
  description = "Name of the loadbalancer. This will be used for DNS entries and ressource names. Example: alb"
}

variable "loadbalancer_dns_ttl" {
  type = "string"
  description = "TTL(in seconds) for DNS records for the loadbalancer."
}

variable "loadbalancer_dns_default_cnames" {
  type = list(string)
  description = "Default CNAME records for the loadbalancer. Example: ['cluster', 'logs', 'elastic', 'kibana', 'hawkular-metrics', 'registry', 'dashboard']"
}

variable "loadbalancer_dns_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['grafana', 'prometheus', 'console']"
}

variable "loadbalancer_dns_ops_default_cnames" {
  type = list(string)
  description = "Default CNAME records for .ops.loadbalancer_name.cluster_name.cluster_domain To use with the OpenShift operator paradigm (see: https://docs.okd.io/3.11/install_config/prometheus_cluster_monitoring.html//configuring-openshift-cluster-monitoring). Example: ['kibana', 'elastic', 'grafana', 'prometheus']"
}

variable "loadbalancer_dns_ops_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_ops_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['sentinel']"
}

variable "loadbalancer_k8s_api_frontend_port" {
  type       = "string"
  description = "Frontend port on the loadbalancer to reach the k8s API."
}

variable "loadbalancer_k8s_api_backend_port" {
  type       = "string"
  description = "Backend port on the Masters where the k8s API will be running."
}

variable "loadbalancer_ingresscontroller_frontend_port" {
  type       = "string"
  description = "Frontend port on the loadbalancer to reach the default ingresscontroller."
}

variable "loadbalancer_ingresscontroller_backend_port" {
  type       = "string"
  description = "Backend port on all nodes where the default ingresscontroller will be running. All Nodes (infra and compute) will be added to the Loadbalancer rule. If the lb doesnt reach the ingresscontroller on compute nodes, they will be automatically marked as unreachable and won't be considered for loadbalancing anymore."
}

variable "loadbalancer_additional_node_loadbalancing_rules"  {
  type = map(string)
  description = "Additional loadbalancing rules for the nodes. Will be created for both UDP and TCP as protocols. Example: { '80' = '31080' }"
}

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

variable "masters_vm_prefix" {
  type        = "string"
  description = "Prefix of the name of the vm resource for the masters. Resource name will be build with pattern (masters_vm_prefix)(index).cluster_name.cluster_domain . Example: master"
}

/////////////////////////////////////////////////////DEPENDENCIES///////////////////////////////////////////////////////

variable "out_platform_dns_zone_name" {
  type = "string"
  description = "Name of the dns zone that was created."
}
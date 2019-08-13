/////////////////////////////////////////////////////PLATFORM///////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////LOADBALANCER/DNS///////////////////////////////////////////////////

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

variable "out_platform_dns_zone_name" {
  type = "string"
  description = "Name of the dns zone that was created."
}
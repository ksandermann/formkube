variable "platform_fqdn" {
  type = "string"
  description = "FQDN of the cluster. Example: k8s-dev.example.com"
}

variable "aks_cluster_k8s_ad_server_app_secret" {
  type = "string"
  description = "AppSecret of the Azure AD Server Application used to integrate Kubernetes with Azure AD."
}
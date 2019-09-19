output "out_admin_kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive   = true
}

output "out_user_kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "out_aks_cluster_k8s_ad_client_app_id" {
  value       = var.aks_cluster_k8s_ad_client_app_id
}

output "out_aks_cluster_k8s_ad_server_app_id" {
  value       =  var.aks_cluster_k8s_ad_server_app_id
}

output "out_aks_cluster_k8s_ad_server_app_secret" {
  value       = var.aks_cluster_k8s_ad_server_app_secret
  sensitive   = true
}

output "out_loadbalancer_public_ip" {
  value       = azurerm_public_ip.loadbalancer.ip_address
}

output "out_admin_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}

output "out_user_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "out_aks_cluster_k8s_ad_client_app_id" {
  value = var.aks_cluster_k8s_ad_client_app_id
}

output "out_aks_cluster_k8s_ad_server_app_id" {
  value =  var.aks_cluster_k8s_ad_server_app_id

}

output "out_aks_cluster_k8s_ad_server_app_secret" {
  value = var.aks_cluster_k8s_ad_server_app_secret

}
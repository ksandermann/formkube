output "out_admin_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}

output "out_user_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
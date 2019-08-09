output "out_kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}
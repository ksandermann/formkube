output "out_aks_cluster_k8s_ad_client_app_id" {
  value = azuread_application.client.application_id
  description = "AppID of the Azure AD Client Application used to integrate Kubernetes with Azure AD."
}

output "out_aks_cluster_k8s_ad_server_app_id" {
  value = azuread_application.server.application_id
  description = "AppID of the Azure AD Server Application used to integrate Kubernetes with Azure AD."
}

output "out_aks_cluster_k8s_ad_server_app_secret" {
  value = azuread_service_principal_password.server.value
  description = "AppSecret of the Azure AD Server Application used to integrate Kubernetes with Azure AD."
}

#debug
output "out_aks_cluster_k8s_ad_server_sp_appid" {
  value = azuread_service_principal.server.application_id
  description = "AppSecret of the Azure AD Server Application used to integrate Kubernetes with Azure AD."
}
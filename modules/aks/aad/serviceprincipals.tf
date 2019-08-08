resource "azuread_service_principal" "server" {
  application_id = azuread_application.server.application_id
}


resource "azuread_service_principal_password" "server" {
  service_principal_id = azuread_service_principal.server.id
  value                = var.aks_cluster_k8s_ad_server_app_secret
  //10 years
  end_date_relative    = "87600h"
}
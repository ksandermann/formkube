output "admin_kube_config" {
  value = "\n${module.cluster.out_admin_kube_config}"
  sensitive   = true
}

output "user_kube_config" {
  value = "\n${module.cluster.out_user_kube_config}"
  sensitive   = true
}

output "loadbalancer_public_ip" {
  value = module.cluster.out_loadbalancer_public_ip
}

output "aad_client_app_id" {
  value = module.cluster.out_aks_cluster_k8s_ad_client_app_id
}

output "aad_server_app_id" {
  value =  module.cluster.out_aks_cluster_k8s_ad_server_app_id

}

output "aad_server_app_secret" {
  value = module.cluster.out_aks_cluster_k8s_ad_server_app_secret
  sensitive   = true
}

output "admin_kube_config" {
  value = "\n${module.cluster.out_admin_kube_config}"
}

output "user_kube_config" {
  value = "\n${module.cluster.out_user_kube_config}"
}

output "loadbalancer_public_ip" {
  value = module.dns.out_loadbalancer_public_ip
}
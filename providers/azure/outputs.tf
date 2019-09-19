output "out_masters_os_disk_delete_on_destroy" {
  value       = module.masters.out_masters_os_disk_delete_on_destroy
  description = "Indicates if the os disk of the masters should be deleted when deleting the vm. This output is only needed to print proper messages on terraform destroy. "
}

output "out_platform_dns_zone_name_servers" {
  value       = module.essentials.out_platform_dns_zone_name_servers
  description = "A list of values that make up the NS record for the zone."
}

output "out_bastions_nics_public_ips" {
  value       = module.vnet.out_bastions_nics_public_ips
  description = "Public IPs of the NICs created for the bastions."
}

output "out_masters_nics_ips" {
  value       = module.vnet.out_masters_nics_ips
  description = "Private IPs of the NICs created for the masters."
}

output "out_computenodes_nics_ips" {
  value       = module.vnet.out_computenodes_nics_ips
  description = "Private IPs of the NICs created for the computenodes."
}

output "out_infranodes_nics_ips" {
  value       = module.vnet.out_infranodes_nics_ips
  description = "Private IPs of the NICs created for the infranodes."
}

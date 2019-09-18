output "out_masters_os_disk_delete_on_destroy" {
  value       = module.masters.out_masters_os_disk_delete_on_destroy
  description = "Indicates if the os disk of the masters should be deleted when deleting the vm. This output is only needed to print proper messages on terraform destroy. "
}

output "out_platform_dns_zone_name_servers" {
  value       = module.essentials.out_platform_dns_zone_name_servers
  description = "A list of values that make up the NS record for the zone."
}

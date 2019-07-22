output "out_masters_os_disk_delete_on_destroy" {
  value       = module.masters.out_masters_os_disk_delete_on_destroy
  description = "Indicates if the os disk of the masters should be deleted when deleting the vm. This output is only needed to print proper messages on terraform destroy. "
}
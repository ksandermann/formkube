output "out_masters_vm_ids" {
  value       = azurerm_virtual_machine.masters.*.id
  description = "IDs of the master VMs that were created."
}

output "out_masters_os_disk_delete_on_destroy" {
  value       = var.masters_os_disk_delete_on_destroy
  description = "Indicates if the os disk of the masters should be deleted when deleting the vm. This output is only needed to print proper messages on terraform destroy. "
}
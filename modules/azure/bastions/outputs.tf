output "out_bastions_vm_ids" {
  value       = azurerm_virtual_machine.bastions.*.id
  description = "IDs of the bastion VMs that were created."
}
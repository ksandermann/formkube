output "out_computenodes_vm_ids" {
  value       = azurerm_virtual_machine.computenodes.*.id
  description = "IDs of the computenode VMs that were created."
}

output "out_infranodes_vm_ids" {
  value       = azurerm_virtual_machine.infranodes.*.id
  description = "IDs of the infranode VMs that were created."
}
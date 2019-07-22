output "out_masters_nics_ids" {
  value       = azurerm_network_interface.masters.*.id
  description = "IDs of the NICs created for the masters."
}

output "out_computenodes_nics_ids" {
  value       = azurerm_network_interface.computenodes.*.id
  description = "IDs of the NICs created for the computenodes."
}

output "out_infranodes_nics_ids" {
  value       = azurerm_network_interface.infranodes.*.id
  description = "IDs of the NICs created for the infranodes."
}

output "out_bastions_nics_ids" {
  value       = azurerm_network_interface.bastions.*.id
  description = "IDs of the NICs created for the bastion."
}
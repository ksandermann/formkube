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
  description = "IDs of the NICs created for the bastions."
}

output "out_bastions_nics_ips" {
  value       = azurerm_network_interface.bastions.*.ip_configuration.0.private_ip_address
  description = "Private IPs of the NICs created for the bastions."
}

output "out_masters_nics_ips" {
  value       = azurerm_network_interface.masters.*.ip_configuration.0.private_ip_address
  description = "Private IPs of the NICs created for the masters."
}

output "out_computenodes_nics_ips" {
  value       = azurerm_network_interface.computenodes.*.ip_configuration.0.private_ip_address
  description = "Private IPs of the NICs created for the computenodes."
}

output "out_infranodes_nics_ips" {
  value       = azurerm_network_interface.infranodes.*.ip_configuration.0.private_ip_address
  description = "Private IPs of the NICs created for the infranodes."
}

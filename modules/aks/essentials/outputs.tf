// need to output this to ensure resource group exists when applying other resources on first bootstrap
output "out_platform_rg_name" {
  value       = azurerm_resource_group.platform.name
  description = "Name of the ressource group that was created."
}

output "out_log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.platform.id
  description = "ID of the Log Analytics Workspace that was created."
}
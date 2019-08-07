resource "azurerm_log_analytics_workspace" "platform" {
  name                = "logs.${var.platform_fqdn}"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "platform" {
  solution_name         = "containers.${var.platform_fqdn}"
  location              = azurerm_resource_group.platform.location
  resource_group_name   = azurerm_resource_group.platform.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
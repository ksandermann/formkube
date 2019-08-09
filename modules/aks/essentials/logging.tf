resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "platform" {
  name                  = "${replace(var.platform_fqdn, "/[^a-zA-Z0-9\\-]/", "-")}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location              = azurerm_resource_group.platform.location
  resource_group_name   = azurerm_resource_group.platform.name
  sku                   = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "platform" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.platform.location
  resource_group_name   = azurerm_resource_group.platform.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher           = "Microsoft"
    product             = "OMSGallery/ContainerInsights"
  }
}
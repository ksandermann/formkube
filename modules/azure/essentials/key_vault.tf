resource "azurerm_key_vault" "platform" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.platform.location
  resource_group_name         = azurerm_resource_group.platform.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tf_tenant_id
  sku_name                    = "standard"
  tags                        = var.platform_resource_tags
  depends_on                  = [azurerm_resource_group.platform]

  network_acls {
    default_action            = "Allow"
    bypass                    = "AzureServices"
  }

  lifecycle {
    //KNOWNISSUE - setting network_acls here results in terraform always thinking it is changing the infrastructure
    ignore_changes            = [network_acls]
  }
}


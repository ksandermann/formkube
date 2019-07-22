resource "azurerm_key_vault_access_policy" "test" {
  key_vault_id = var.out_key_vault_id
  tenant_id = var.out_key_vault_tenant_id
  //TODO pass this
  //TODO test if this is set to garbage, if access can be granted on Azure Portal anyway -> yes
  object_id = ""

  //TODO adjust to only what is necessary
  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set"
  ]

  storage_permissions = [
    "get",
  ]
}
resource "azurerm_key_vault_secret" "ssh-pub" {
  name         = "bastions-pubkey"
  key_vault_id = var.out_key_vault_id
  depends_on = [azurerm_key_vault_access_policy.test, data.external.bastion_ssh_keys]
  value = base64decode(data.external.bastion_ssh_keys.result.public_key_b64encoded)
}
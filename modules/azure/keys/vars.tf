// need to output this to ensure vault exists when applying other resources on first bootstrap
variable "out_key_vault_id" {
  type = "string"
  description = "ID of the key vault that was created."
}

variable "out_key_vault_tenant_id" {
  type = "string"
  description = "ID of the tenant of the key vault that was created."
}

variable "cluster_fqdn" {
  type = "string"
  description = "FQDN of the cluster. Example: k8s-dev.exmaple.com"
}
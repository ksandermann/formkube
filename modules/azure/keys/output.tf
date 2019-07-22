output "out_bastion_public_ssh_key_b64encoded" {
  value       = data.external.bastion_ssh_keys.result.public_key_b64encoded
  description = "Public SSH key of the bastions. B64 encoded."
}
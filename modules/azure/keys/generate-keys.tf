
data "external" "bastion_ssh_keys" {
  //TODO linebreaks in SSH keys missing (?)
  //TODO re-applying not working ->  command "bash" produced invalid JSON: invalid character '/' looking for beginning of value
  //TODO created folder structure breaking
  //bash ./modules/keys/generate-keys.sh clusters/testcluster/ssh_keys bastions
  //TODO ssh key not working (ssh throwing file too short errors - > different error in ubuntu then in macos)
  //https://www.terraform.io/docs/providers/tls/r/private_key.html -> not for prd usage
  //TODO will this be stored in the statefile?


  program = ["bash", "${path.module}/generate-keys.sh", "/root/project/clusters/${var.cluster_fqdn}/ssh_keys", "${var.cluster_fqdn}_bastions"]

}

data "external" "cluster_ssh_keys" {

  program = ["bash", "${path.module}/generate-keys.sh", "/root/project/clusters/${var.cluster_fqdn}/ssh_keys", "${var.cluster_fqdn}_cluster"]

}
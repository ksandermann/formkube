////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////MANDATORY//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

variable "platform_rg_name" {
  type = "string"
  description = "Name of the resource group to create for the platform. It is recommended to not use an existing rg. Example: k8s-dev.example.com"
}

variable "platform_location" {
  type = "string"
  description = "Region of the resource group to create for the platform. It is recommended to not use an existing rg. Example: westeurope"
}

variable "cluster_name" {
  type = "string"
  description = "Name of the cluster. This is NOT the FQDN, cluster will be named cluster_name.cluster_domain. Example: k8s-dev"
}

variable "cluster_domain" {
  type = "string"
  description = "domain of the cluster. No leading '.' needed. Example: example.com"
}

variable "bastions_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the bastion"
}

variable "masters_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the masters"
}

variable "computenodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the compute nodes."
}

variable "infranodes_pub_key_controller_path" {
  type = "string"
  description = "Path on the controller node running terraform to the public ssh key to place into authorized_keys for the admin user on the infra nodes."
}

variable "platform_staging_environment"  {
  type = "string"
  description = "Stage of the platform."
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////OPTIONAL///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////PLATFORM///////////////////////////////////////////////////////////

variable "platform_network_CIDRs" {
  type    = list(string)
  description = "CIDRs of the network for the cluster (Masters and Nodes). Do NOT change this after initial deployment."
  default = ["10.0.0.0/16"]
}

variable "platform_network_bastion_subnet_CIDR" {
  type    = "string"
  description = "CIDRs of the subnet for the bastion. Has to be a subset of the CIDRs defined in cluster_network_CIDRs . Do NOT change this after initial deployment."
  default = "10.0.2.0/24"
}

variable "platform_network_cluster_subnet_CIDR" {
  type    = "string"
  description = "CIDRs of the subnet for the cluster (Masters and Nodes). Has to be a subset of the CIDRs defined in cluster_network_CIDRs . Do NOT change this after initial deployment."
  default = "10.0.1.0/24"
}

variable "platform_resource_tags_additional"  {
  type = map(string)
  description = "Additional tags added to all Azure ressources. Default values are ClusterName, ClusterDomain and ClusterFQDN."
  default = {}
}

/////////////////////////////////////////////////////BASTIONS///////////////////////////////////////////////////////////

variable "bastions_amount" {
  type = "string"
  description = "Number of bastions to create."
  default = "2"
}

variable "bastions_fault_domains" {
  type = "string"
  description = "Number of fault domains for the availibility set of the bastions. This is depending on the region that you are using. https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md"
  default = "2"
}

variable "bastions_vm_type" {
  type = "string"
  description = "Type of the vm for the bastion. Example: Standard_DS1_v2"
  default = "Standard_DS1_v2"
}

variable "bastions_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the bastions. Resource name will be build with pattern (bastions_vm_prefix)(index).cluster_name.cluster_domain . Example: bastion"
  default = "bastion"
}

variable "bastions_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disk of the bastion. Resource name will be build with pattern bastion.cluster_name.cluster_domain-bastion_os_disk_suffix . Example: system"
  default = "system"
}

variable "bastions_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disk for the bastion . Example: 30"
  default = "30"
}

variable "bastions_admin_username" {
  type = "string"
  description = "Name of the admin user on the bastion. Must not be admin or root Example: operator"
  default = "clusteradmin"
}

variable "bastions_os_disk_type" {
  type = "string"
  description = "Disk type of the os disk of the bastion. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
  default = "Standard_LRS"
}

variable "bastions_os_image_publisher" {
  type = "string"
  description = "Image publisher for the bastion OS. Only Linux supported. Example: Canonical"
  default = "Canonical"
}

variable "bastions_os_image_offer" {
  type = "string"
  description = "Image offer for the bastion OS. Only Linux supported. Example: UbuntuServer"
  default = "UbuntuServer"
}

variable "bastions_os_image_sku" {
  type = "string"
  description = "Image sku for the bastion OS. Only Linux supported. Example: 18.04-LTS"
  default = "18.04-LTS"
}

variable "bastions_os_image_version" {
  type = "string"
  description = "Image version for the bastion OS. Only Linux supported. Example: latest"
  default = "latest"
}

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

variable "masters_amount" {
  type    = "string"
  description = "Number of masters to create."
  default = "3"
}

variable "masters_vm_type" {
  type = "string"
  description = "Type of the vm for the master. Example: Standard_D4_v3"
  default = "Standard_D4_v3"
}

variable "masters_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the masters. Resource name will be build with pattern (masters_vm_prefix)(index).cluster_name.cluster_domain . Example: master"
  default = "master"
}

variable "masters_os_disk_delete_on_destroy" {
  type = bool
  description = "Configures if the os disk of the masters should be deleted when deleting the vm, i.e. with terraform destroy. This will result in not being able to re-apply the same configuration after destroying it."
  default = false
}

variable "masters_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disk of the master. Resource name will be build with pattern master.cluster_name.cluster_domain-master_os_disk_suffix . Example: system"
  default = "system"
}

variable "masters_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disk for the master . Example: 150"
  default = "150"
}

variable "masters_admin_username" {
  type = "string"
  description = "Name of the admin user on the master. Must not be admin or root Example: operator"
  default = "operator"
}

variable "masters_os_disk_type" {
  type = "string"
  description = "Disk type of the os disk of the master. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
  default = "StandardSSD_LRS"
}

variable "masters_os_image_publisher" {
  type = "string"
  description = "Image publisher for the master OS. Only Linux supported. Example: Canonical"
  default = "Canonical"
}

variable "masters_os_image_offer" {
  type = "string"
  description = "Image offer for the master OS. Only Linux supported. Example: UbuntuServer"
  default = "UbuntuServer"
}

variable "masters_os_image_sku" {
  type = "string"
  description = "Image sku for the master OS. Only Linux supported. Example: 18.04-LTS"
  default = "18.04-LTS"
}

variable "masters_os_image_version" {
  type = "string"
  description = "Image version for the master OS. Only Linux supported. Example: latest"
  default = "latest"
}

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

variable "computenodes_amount" {
  type    = "string"
  description = "Number of compute nodes to create."
  default = "3"
}

variable "computenodes_vm_type" {
  type = "string"
  description = "Type of the vm for the compute nodes. Example: Standard_D8_v3"
  default = "Standard_D8_v3"
}

variable "computenodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the compute nodes. Resource name will be build with pattern (computenodes_vm_prefix)(index).cluster_name.cluster_domain . Example: computenode"
  default = "computenode"
}

variable "computenodes_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disks of the compute nodes. Resource name will be build with pattern node.cluster_name.cluster_domain-node_os_disk_suffix . Example: system"
  default = "system"
}

variable "computenodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the compute nodes. Example: 200"
  default = "200"
}

variable "computenodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the compute nodes. Must not be admin or root Example: operator"
  default = "operator"
}

variable "computenodes_os_disk_type" {
  type = "string"
  description = "Disk type of the os disks of the compute nodes. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
  default = "StandardSSD_LRS"
}

variable "computenodes_os_image_publisher" {
  type = "string"
  description = "Image publisher for the compute nodes OS. Only Linux supported. Example: Canonical"
  default = "Canonical"
}

variable "computenodes_os_image_offer" {
  type = "string"
  description = "Image offer for the compute nodes OS. Only Linux supported. Example: UbuntuServer"
  default = "UbuntuServer"
}

variable "computenodes_os_image_sku" {
  type = "string"
  description = "Image sku for the compute nodes OS. Only Linux supported. Example: 18.04-LTS"
  default = "18.04-LTS"
}

variable "computenodes_os_image_version" {
  type = "string"
  description = "Image version for the compute nodes OS. Only Linux supported. Example: latest"
  default = "latest"
}

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

variable "infranodes_amount" {
  type    = "string"
  description = "Number of infra nodes to create."
  default = "3"
}

variable "infranodes_vm_type" {
  type = "string"
  description = "Type of the vm for the infra nodes. Example: Standard_D8_v3"
  default = "Standard_D8_v3"
}

variable "infranodes_vm_prefix" {
  type    = "string"
  description = "Prefix of the name of the vm resource for the infra nodes. Resource name will be build with pattern (infranodes_vm_prefix)(index).cluster_name.cluster_domain . Example: infranode"
  default = "infranode"
}

variable "infranodes_os_disk_suffix" {
  type = "string"
  description = "Suffix to append to the name of the disk resource for the os disks of the infra nodes. Resource name will be build with pattern node.cluster_name.cluster_domain-node_os_disk_suffix . Example: system"
  default = "system"
}

variable "infranodes_os_disk_size_gb" {
  type = "string"
  description = "Size of the OS disks for the infra nodes. Example: 200"
  default = "200"
}

variable "infranodes_admin_username" {
  type = "string"
  description = "Name of the admin user on the infra nodes. Must not be admin or root Example: operator"
  default = "operator"
}

variable "infranodes_os_disk_type" {
  type = "string"
  description = "Disk type of the os disks of the infra nodes. Options: Standard_LRS, StandardSSD_LRS or Premium_LRS."
  default = "StandardSSD_LRS"
}

variable "infranodes_os_image_publisher" {
  type = "string"
  description = "Image publisher for the infra nodes OS. Only Linux supported. Example: Canonical"
  default = "Canonical"
}

variable "infranodes_os_image_offer" {
  type = "string"
  description = "Image offer for the infra nodes OS. Only Linux supported. Example: UbuntuServer"
  default = "UbuntuServer"
}

variable "infranodes_os_image_sku" {
  type = "string"
  description = "Image sku for the infra nodes OS. Only Linux supported. Example: 18.04-LTS"
  default = "18.04-LTS"
}

variable "infranodes_os_image_version" {
  type = "string"
  description = "Image version for the infra nodes OS. Only Linux supported. Example: latest"
  default = "latest"
}

/////////////////////////////////////////////////////LOADBALANCER///////////////////////////////////////////////////////

variable "loadbalancer_dns_name" {
  type = "string"
  description = "Name of the loadbalancer. This will be used for DNS entries and ressource names. Example: alb"
  default = "alb"
}

variable "loadbalancer_dns_ttl" {
  type = "string"
  description = "TTL (in seconds) for DNS records for the loadbalancer."
  default = "300"
}

variable "loadbalancer_dns_default_cnames" {
  type = list(string)
  description = "Default CNAME records for the loadbalancer. Example: ['cluster', 'logs', 'elastic', 'kibana', 'hawkular-metrics', 'registry', 'dashboard']"
  default = ["api","cluster", "logs", "elastic", "kibana", "hawkular-metrics", "registry", "dashboard"]
}

variable "loadbalancer_dns_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['grafana', 'prometheus', 'console']"
  default = []
}

variable "loadbalancer_dns_ops_default_cnames" {
  type = list(string)
  description = "Default CNAME records for .ops.loadbalancer_name.cluster_name.cluster_domain To use with the OpenShift operator paradigm (see: https://docs.okd.io/3.11/install_config/prometheus_cluster_monitoring.html//configuring-openshift-cluster-monitoring). Example: ['kibana', 'elastic', 'grafana', 'prometheus']"
  default = ["kibana", "elastic", "grafana", "prometheus"]
}

variable "loadbalancer_dns_ops_additional_cnames" {
  type = list(string)
  description = "Additional CNAME records to create for the loadbalancer. Default CNAMEs defined in loadbalancer_ops_default_cnames must NOT be included here. only domain prefix is needed, no FQDN Example: ['sentinel']"
  default = []
}

variable "loadbalancer_k8s_api_frontend_port" {
  type       = "string"
  description = "Frontend port on the loadbalancer to reach the k8s API."
  default = "6443"
}

variable "loadbalancer_k8s_api_backend_port" {
  type       = "string"
  description = "Backend port on the Masters where the k8s API will be running."
  default = "6443"
}

variable "loadbalancer_ingresscontroller_frontend_port" {
  type       = "string"
  description = "Frontend port on the loadbalancer to reach the default ingresscontroller."
  default = "443"
}

variable "loadbalancer_ingresscontroller_backend_port" {
  type       = "string"
  description = <<EOF
  Backend port on all nodes where the default ingresscontroller will be running.
  All Nodes (infra and compute) will be added to the Loadbalancer rule.
  If the lb doesnt reach the ingresscontroller on compute nodes, they will be automatically marked as unreachable and
  won't be considered for loadbalancing anymore.
  It is recommended to not use host-port 443 on the nodes but rather use NodePort 30443 on the nodes for the ingress
  controller/router
  EOF
  default = "30443"
}


variable "loadbalancer_additional_node_loadbalancing_rules"  {
  type = map(string)
  description = "Additional loadbalancing rules for the nodes. Will be created for both UDP and TCP as protocols Example: { '80' = '31080' }"
  default = {}
}

/////////////////////////////////////////////////////BACKUP/////////////////////////////////////////////////////////////

variable "backup_vault_name" {
  type = "string"
  description = "Specifies the name of the Recovery Services Vault used for all VMs. Changing this forces a new resource to be created. Only letters, numbers and hyphens allowed"
  default = "ClusterBackup"
}

variable "bastions_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the bastions. true = backup enabled"
  default = false
}

variable "bastions_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the bastions backups. Example: 'UTC'"
  default = "UTC"
}

variable "bastions_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the bastions. Must be either Daily or Weekly."
  default = "Weekly"
}

variable "bastions_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
  default = "23:00"
}

variable "bastions_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "bastions_backup_daily_retentions" {
  type = "string"
  description = <<EOF
  The number of daily backups to keep.
  Must be between 7 and 9999.
  The officially documented range of 1 - 9999 does not work due to a known bug in the Azure API.
  For more information, see :https://github.com/Azure/azure-sdk-for-go/issues/2822//issuecomment-502986572
  EOF
  default = "7"
}

variable "bastions_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "bastions_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "bastions_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "bastions_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "bastions_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "bastions_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "bastions_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "bastions_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "bastions_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
  default = ["December"]
}

variable "masters_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the masters. true = backup enabled"
  default = true
}

variable "masters_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the masters backups. Example: 'UTC'"
  default = "UTC"
}

variable "masters_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the masters. Must be either Daily or Weekly."
  default = "Daily"
}

variable "masters_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
  default = "23:00"
}

variable "masters_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "masters_backup_daily_retentions" {
  type = "string"
  description = <<EOF
  The number of daily backups to keep.
  Must be between 7 and 9999.
  The officially documented range of 1 - 9999 does not work due to a known bug in the Azure API.
  For more information, see :https://github.com/Azure/azure-sdk-for-go/issues/2822//issuecomment-502986572
  EOF
  default = "14"
}

variable "masters_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
  default = "2"
}

variable "masters_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "masters_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "masters_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "masters_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "masters_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "masters_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "masters_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "masters_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
  default = ["December"]
}

variable "computenodes_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the computenodes. true = backup enabled"
  default = false
}

variable "computenodes_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the computenodes backups. Example: 'UTC'"
  default = "UTC"
}

variable "computenodes_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the computenodes. Must be either Daily or Weekly."
  default = "Weekly"
}

variable "computenodes_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
  default = "23:00"
}

variable "computenodes_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "computenodes_backup_daily_retentions" {
  type = "string"
  description = <<EOF
  The number of daily backups to keep.
  Must be between 7 and 9999.
  The officially documented range of 1 - 9999 does not work due to a known bug in the Azure API.
  For more information, see :https://github.com/Azure/azure-sdk-for-go/issues/2822//issuecomment-502986572
  EOF
  default = "7"
}

variable "computenodes_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
  default = "2"
}

variable "computenodes_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "computenodes_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "computenodes_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "computenodes_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "computenodes_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "computenodes_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "computenodes_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "computenodes_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
  default = ["December"]
}

variable "infranodes_backup_enabled" {
  type = bool
  description = "Boolean to enabled backup of the infranodes. true = backup enabled"
  default = false
}

variable "infranodes_backup_timezone" {
  type = "string"
  description = "Specifies the timezone used for the infranodes backups. Example: 'UTC'"
  default = "UTC"
}

variable "infranodes_backup_frequency" {
  type = "string"
  description = "Sets the backup frequency of the infranodes. Must be either Daily or Weekly."
  default = "Weekly"
}

variable "infranodes_backup_time" {
  description = "The time of day to preform the backup in 24hour format. Example : '23:00'"
  default = "23:00"
}

variable "infranodes_backup_weekdays" {
  type = list(string)
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "infranodes_backup_daily_retentions" {
  type = "string"
  description = <<EOF
  The number of daily backups to keep.
  Must be between 7 and 9999.
  The officially documented range of 1 - 9999 does not work due to a known bug in the Azure API.
  For more information, see :https://github.com/Azure/azure-sdk-for-go/issues/2822//issuecomment-502986572
  EOF
  default = "7"
}

variable "infranodes_backup_weekly_retentions" {
  type = "string"
  description = "The number of weekly backups to keep. Must be between 1 and 9999"
  default = "2"
}

variable "infranodes_backup_weekly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for weekly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "infranodes_backup_monthly_retentions" {
  type = "string"
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "infranodes_backup_monthly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for monthly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "infranodes_backup_monthly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for monthly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "infranodes_backup_yearly_retentions" {
  type = "string"
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
  default = "1"
}

variable "infranodes_backup_yearly_weekdays" {
  type = list(string)
  description = "The weekday backups to retain for yearly backups. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  default = ["Thursday"]
}

variable "infranodes_backup_yearly_weeks" {
  type = list(string)
  description = "The weeks of the month to retain backups of (for yearly backups). Must be one of First, Second, Third, Fourth, Last."
  default = ["Last"]
}

variable "infranodes_backup_yearly_months" {
  type = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December"
  default = ["December"]
}
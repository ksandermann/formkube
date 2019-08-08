////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////MANDATORY//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

platform_rg_name="samplecluster-prd.example.com"
platform_location="westeurope"

cluster_name="samplecluster-prd"
cluster_domain="example.com"

bastions_pub_key_controller_path="~/.ssh/samplecluster-prd.example.com_bastions.pub"
masters_pub_key_controller_path="~/.ssh/samplecluster-prd.example.com_cluster.pub"
computenodes_pub_key_controller_path="~/.ssh/samplecluster-prd.example.com_cluster.pub"
infranodes_pub_key_controller_path="~/.ssh/samplecluster-prd.example.com_cluster.pub"

platform_staging_environment="prd"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////OPTIONAL///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////PLATFORM///////////////////////////////////////////////////////////

platform_network_CIDRs=["10.0.0.0/16"]

platform_network_bastion_subnet_CIDR="10.0.2.0/24"

platform_network_cluster_subnet_CIDR="10.0.1.0/24"

#would be adjusted if using openshift
platform_resource_tags_additional={"ClusterType" = "K8S_14.03"}

/////////////////////////////////////////////////////BASTIONS///////////////////////////////////////////////////////////

bastions_amount="2"
bastions_fault_domains = "2"
bastions_vm_type="Standard_DS1_v2"
bastions_vm_prefix="bastion"
bastions_admin_username="clusteradmin"

bastions_os_disk_suffix="system"
bastions_os_disk_size_gb="30"
bastions_os_disk_type="Standard_LRS"
bastions_os_image_publisher="Canonical"
bastions_os_image_offer="UbuntuServer"
bastions_os_image_sku="18.04-LTS"
bastions_os_image_version="latest"

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

masters_amount="3"
masters_fault_domains = "2"
masters_vm_type="Standard_D4s_v3"
masters_vm_prefix="master"
masters_admin_username="clusteradmin"
masters_os_disk_delete_on_destroy=false

masters_os_disk_suffix="system"
masters_os_disk_size_gb="150"
masters_os_disk_type="Premium_LRS"
masters_os_image_publisher="Canonical"
masters_os_image_offer="UbuntuServer"
masters_os_image_sku="18.04-LTS"
masters_os_image_version="latest"

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

computenodes_amount="3"
computenodes_fault_domains = "2"
computenodes_vm_type="Standard_D8s_v3"
computenodes_vm_prefix="computenode"
computenodes_admin_username="clusteradmin"

computenodes_os_disk_suffix="system"
computenodes_os_disk_size_gb="200"
computenodes_os_disk_type="Premium_LRS"
computenodes_os_image_publisher="Canonical"
computenodes_os_image_offer="UbuntuServer"
computenodes_os_image_sku="18.04-LTS"
computenodes_os_image_version="latest"

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

infranodes_amount="3"
infranodes_fault_domains = "2"
infranodes_vm_type="Standard_D8s_v3"
infranodes_vm_prefix="infranode"
infranodes_admin_username="clusteradmin"

infranodes_os_disk_suffix="system"
infranodes_os_disk_size_gb="200"
infranodes_os_disk_type="Premium_LRS"
infranodes_os_image_publisher="Canonical"
infranodes_os_image_offer="UbuntuServer"
infranodes_os_image_sku="18.04-LTS"
infranodes_os_image_version="latest"

/////////////////////////////////////////////////////LOADBALANCER///////////////////////////////////////////////////////

loadbalancer_dns_name="alb"

loadbalancer_dns_ttl="300"

loadbalancer_dns_default_cnames=["api", "cluster", "logs", "elastic", "kibana", "hawkular-metrics", "registry", "dashboard"]
loadbalancer_dns_additional_cnames=["os"]

loadbalancer_dns_ops_default_cnames=["kibana", "elastic", "grafana", "prometheus"]
loadbalancer_dns_ops_additional_cnames=[]

loadbalancer_k8s_api_frontend_port="6443"
loadbalancer_k8s_api_backend_port="6443"

loadbalancer_ingresscontroller_frontend_port="443"
loadbalancer_ingresscontroller_backend_port="30443"

loadbalancer_additional_node_loadbalancing_rules={ "80" = "30080" }


/////////////////////////////////////////////////////BACKUP/////////////////////////////////////////////////////////////

backup_vault_name="SampleClusterPrdBackup"

bastions_backup_enabled=true
bastions_backup_timezone="UTC"
bastions_backup_frequency="Weekly"
bastions_backup_time="23:00"
bastions_backup_weekdays=["Thursday"]
bastions_backup_daily_retentions="7"
bastions_backup_weekly_retentions="1"
bastions_backup_weekly_weekdays=["Thursday"]
bastions_backup_monthly_retentions="1"
bastions_backup_monthly_weekdays=["Thursday"]
bastions_backup_monthly_weeks=["Last"]
bastions_backup_yearly_retentions="1"
bastions_backup_yearly_weekdays=["Thursday"]
bastions_backup_yearly_weeks=["Last"]
bastions_backup_yearly_months=["December"]

masters_backup_enabled=true
masters_backup_timezone="UTC"
masters_backup_frequency="Daily"
masters_backup_time="23:00"
masters_backup_weekdays=["Thursday"]
masters_backup_daily_retentions="14"
masters_backup_weekly_retentions="2"
masters_backup_weekly_weekdays=["Thursday"]
masters_backup_monthly_retentions="1"
masters_backup_monthly_weekdays=["Thursday"]
masters_backup_monthly_weeks=["Last"]
masters_backup_yearly_retentions="1"
masters_backup_yearly_weekdays=["Thursday"]
masters_backup_yearly_weeks=["Last"]
masters_backup_yearly_months=["December"]

computenodes_backup_enabled=true
computenodes_backup_timezone="UTC"
computenodes_backup_frequency="Weekly"
computenodes_backup_time="23:00"
computenodes_backup_weekdays=["Thursday"]
computenodes_backup_daily_retentions="7"
computenodes_backup_weekly_retentions="2"
computenodes_backup_weekly_weekdays=["Thursday"]
computenodes_backup_monthly_retentions="1"
computenodes_backup_monthly_weekdays=["Thursday"]
computenodes_backup_monthly_weeks=["Last"]
computenodes_backup_yearly_retentions="1"
computenodes_backup_yearly_weekdays=["Thursday"]
computenodes_backup_yearly_weeks=["Last"]
computenodes_backup_yearly_months=["December"]

infranodes_backup_enabled=true
infranodes_backup_timezone="UTC"
infranodes_backup_frequency="Weekly"
infranodes_backup_time="23:00"
infranodes_backup_weekdays=["Thursday"]
infranodes_backup_daily_retentions="7"
infranodes_backup_weekly_retentions="2"
infranodes_backup_weekly_weekdays=["Thursday"]
infranodes_backup_monthly_retentions="1"
infranodes_backup_monthly_weekdays=["Thursday"]
infranodes_backup_monthly_weeks=["Last"]
infranodes_backup_yearly_retentions="1"
infranodes_backup_yearly_weekdays=["Thursday"]
infranodes_backup_yearly_weeks=["Last"]
infranodes_backup_yearly_months=["December"]
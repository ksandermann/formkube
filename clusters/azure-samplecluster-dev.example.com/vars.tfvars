////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////MANDATORY//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

platform_rg_name="samplecluster-dev.example.com"
platform_location="northeurope"

cluster_name="samplecluster-dev"
cluster_domain="example.com"

bastions_pub_key_controller_path="~/.ssh/samplecluster-dev.example.com_bastions.pub"
masters_pub_key_controller_path="~/.ssh/samplecluster-dev.example.com_cluster.pub"
computenodes_pub_key_controller_path="~/.ssh/samplecluster-dev.example.com_cluster.pub"
infranodes_pub_key_controller_path="~/.ssh/samplecluster-dev.example.com_cluster.pub"

platform_staging_environment="dev"

backend_resourcegroup_name="samplecluster-dev.example.comFormKubeState"
backend_storageaccount_name="samplecluster-dev.example.com"
backend_storagecontainer_name="samplecluster-dev.example.com"

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

bastions_amount="1"
bastions_fault_domains = "2"
bastions_vm_type="Standard_DS1_v2"
bastions_vm_prefix="bastion"
bastions_admin_username="clusteradmin"

bastions_os_disk_suffix="system"
bastions_os_disk_size_gb="30"
bastions_os_disk_type="Premium_LRS"
bastions_os_image_publisher="Canonical"
bastions_os_image_offer="UbuntuServer"
bastions_os_image_sku="18.04-LTS"
bastions_os_image_version="latest"

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

masters_amount="1"
masters_fault_domains = "2"
masters_vm_type="Standard_D4s_v3"
masters_vm_prefix="master"
masters_admin_username="clusteradmin"
masters_os_disk_delete_on_destroy=true

masters_os_disk_suffix="system"
masters_os_disk_size_gb="100"
masters_os_disk_type="Premium_LRS"
masters_os_image_publisher="Canonical"
masters_os_image_offer="UbuntuServer"
masters_os_image_sku="18.04-LTS"
masters_os_image_version="latest"

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

computenodes_amount="1"
computenodes_fault_domains = "2"
computenodes_vm_type="Standard_D4s_v3"
computenodes_vm_prefix="computenode"
computenodes_admin_username="clusteradmin"

computenodes_os_disk_suffix="system"
computenodes_os_disk_size_gb="100"
computenodes_os_disk_type="Premium_LRS"
computenodes_os_image_publisher="Canonical"
computenodes_os_image_offer="UbuntuServer"
computenodes_os_image_sku="18.04-LTS"
computenodes_os_image_version="latest"

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

infranodes_amount="1"
infranodes_fault_domains = "2"
infranodes_vm_type="Standard_D4s_v3"
infranodes_vm_prefix="infranode"
infranodes_admin_username="clusteradmin"

infranodes_os_disk_suffix="system"
infranodes_os_disk_size_gb="100"
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

bastions_backup_enabled=false
masters_backup_enabled=false
computenodes_backup_enabled=false
infranodes_backup_enabled=false

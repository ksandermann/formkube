////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////MANDATORY//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

platform_rg_name="formkube-test.sandermann.cloud"
platform_location="westeurope"

cluster_name="formkube-test"
cluster_domain="sandermann.cloud"

bastions_pub_key_controller_path="~/.ssh/k8s-home-bastion.pub"
masters_pub_key_controller_path="~/.ssh/k8s-home-bastion.pub"
computenodes_pub_key_controller_path="~/.ssh/k8s-home-bastion.pub"
infranodes_pub_key_controller_path="~/.ssh/k8s-home-bastion.pub"

platform_staging_environment="dev"

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
bastions_admin_username="kevin"

bastions_os_disk_suffix="system"
bastions_os_disk_size_gb="30"
bastions_os_disk_type="Standard_LRS"
bastions_os_image_publisher="Canonical"
bastions_os_image_offer="UbuntuServer"
bastions_os_image_sku="18.04-LTS"
bastions_os_image_version="latest"

/////////////////////////////////////////////////////MASTERS////////////////////////////////////////////////////////////

masters_amount="0"
masters_fault_domains = "2"
masters_vm_type="Standard_DS1_v2"
masters_vm_prefix="master"
masters_admin_username="kevin"
masters_os_disk_delete_on_destroy=true

masters_os_disk_suffix="system"
masters_os_disk_size_gb="50"
masters_os_disk_type="Standard_LRS"
masters_os_image_publisher="Canonical"
masters_os_image_offer="UbuntuServer"
masters_os_image_sku="18.04-LTS"
masters_os_image_version="latest"

/////////////////////////////////////////////////////COMPUTENODES///////////////////////////////////////////////////////

computenodes_amount="0"
computenodes_vm_type="Standard_DS1_v2"
computenodes_vm_prefix="computenode"
computenodes_admin_username="kevin"

computenodes_os_disk_suffix="system"
computenodes_os_disk_size_gb="100"
computenodes_os_disk_type="Standard_LRS"
computenodes_os_image_publisher="Canonical"
computenodes_os_image_offer="UbuntuServer"
computenodes_os_image_sku="18.04-LTS"
computenodes_os_image_version="latest"

/////////////////////////////////////////////////////INFRANODES/////////////////////////////////////////////////////////

infranodes_amount="0"
infranodes_vm_type="Standard_DS1_v2"
infranodes_vm_prefix="infranode"
infranodes_admin_username="clusteradmin"

infranodes_os_disk_suffix="system"
infranodes_os_disk_size_gb="100"
infranodes_os_disk_type="Standard_LRS"
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

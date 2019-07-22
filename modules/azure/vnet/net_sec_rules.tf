resource "azurerm_network_security_rule" "bastion_ssh_to_cluster_egress" {
  name                                        = "BastionsSshToClusterEgress"
  description                                 = "Outbound rule to allow the bastions to SSH to the cluster."
  priority                                    = 160
  direction                                   = "Outbound"
  access                                      = "Allow"
  protocol                                    = "Tcp"
  source_port_range                           = "*"
  source_application_security_group_ids       = [azurerm_application_security_group.bastions.id]
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  destination_port_range                      = "22"
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.bastions.name
}

resource "azurerm_network_security_rule" "bastion_ssh_to_cluster_ingress" {
  name                                        = "BastionsSshToClusterIngress"
  description                                 = "Inbound rule to allow the bastions to SSH to the cluster."
  priority                                    = 160
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "Tcp"
  source_port_range                           = "*"
  source_application_security_group_ids       = [azurerm_application_security_group.bastions.id]
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  destination_port_range                      = 22
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}

resource "azurerm_network_security_rule" "bastion_ssh_public_ingress" {
  name                                        = "PublicSshToBastionsIngress"
  description                                 = "Inbound rule to allow the bastions to be reached via SSH from anywhere."
  priority                                    = 160
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "Tcp"
  source_port_range                           = "*"
  destination_port_range                      = 22
  source_address_prefix                       = "*"
  destination_application_security_group_ids  = [azurerm_application_security_group.bastions.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.bastions.name
}

//the AzureLoadBalancer tag only allows the health probes as incoming traffic, see
//https://social.msdn.microsoft.com/Forums/en-US/e064ee13-10f0-4748-a729-8b2e918df9a9/azure-loadbalancer-not-working-with-vms-nsg-inbound-rule-with-azureloadbalancer-tag?forum=WAVirtualMachinesVirtualNetwork
resource "azurerm_network_security_rule" "loadbalancer_to_cluster_health_probes_ingress" {
  name                                        = "LoadbalancersHealthProbesToClusterIngress"
  description                                 = "Inbound rule to allow health probes from loadbalancers to the cluster."
  priority                                    = 159
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "*"
  source_port_range                           = "*"
  destination_port_range                      = "*"
  source_address_prefix                       = "AzureLoadBalancer"
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}

//this has to be done as traffic going through the loadbalancer is still regarded as public source from Azure NSGs
//this is not a security issue as we are using private networks that are not routed publicely anyway.
//https://social.msdn.microsoft.com/Forums/en-US/e064ee13-10f0-4748-a729-8b2e918df9a9/azure-loadbalancer-not-working-with-vms-nsg-inbound-rule-with-azureloadbalancer-tag?forum=WAVirtualMachinesVirtualNetwork
resource "azurerm_network_security_rule" "loadbalancer_to_k8s_api_traffic_ingress" {
  name                                        = "LoadbalancersToKubernetesAPIIngress"
  description                                 = "Inbound rule to allow incoming traffic to the Kubernetes API from albs. Alb's traffic-source is still considered public from Azure NSGs."
  priority                                    = 158
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "Tcp"
  source_port_range                           = "*"
  destination_port_range                      = var.loadbalancer_k8s_api_backend_port
  source_address_prefix                       = "*"
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}

//this has to be done as traffic going through the loadbalancer is still regarded as public source from Azure NSGs
//this is not a security issue as we are using private networks that are not routed publicely anyway.
//https://social.msdn.microsoft.com/Forums/en-US/e064ee13-10f0-4748-a729-8b2e918df9a9/azure-loadbalancer-not-working-with-vms-nsg-inbound-rule-with-azureloadbalancer-tag?forum=WAVirtualMachinesVirtualNetwork
resource "azurerm_network_security_rule" "loadbalancer_to_ingresscontroller_traffic_ingress" {
  name                                        = "LoadbalancersToIngressControllerIngress"
  description                                 = "Inbound rule to allow incoming traffic to the Ingresscontroller from albs. Alb's traffic-source is still considered public from Azure NSGs."
  priority                                    = 157
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "Tcp"
  source_port_range                           = "*"
  destination_port_range                      = var.loadbalancer_ingresscontroller_backend_port
  source_address_prefix                       = "*"
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}

//this has to be done as traffic going through the loadbalancer is still regarded as public source from Azure NSGs
//this is not a security issue as we are using private networks that are not routed publicely anyway.
//https://social.msdn.microsoft.com/Forums/en-US/e064ee13-10f0-4748-a729-8b2e918df9a9/azure-loadbalancer-not-working-with-vms-nsg-inbound-rule-with-azureloadbalancer-tag?forum=WAVirtualMachinesVirtualNetwork
resource "azurerm_network_security_rule" "loadbalancer_to_cluster_additional_traffic_ingress" {
  count                                       = length(local.additional_node_rules_backend_ports)
  name                                        = "LoadbalancersToClusterIngress${local.additional_node_rules_backend_ports[count.index]}"
  description                                 = "Inbound rule to allow incoming traffic to the Cluster from loadbalancers. This traffic's source is still considered public from Azure NSGs."
  priority                                    = 300 + count.index
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "*"
  source_port_range                           = "*"
  destination_port_range                      = local.additional_node_rules_backend_ports[count.index]
  source_address_prefix                       = "*"
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}

//this is the fix virtual IP address of all azure loadblaancers
//https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-troubleshoot
resource "azurerm_network_security_rule" "loadbalancerVIP_to_cluster_traffic_ingress" {
  name                                        = "ClusterAllowAllFromLoadbalancers"
  description                                 = "Inbound rule to allow incoming traffic to the cluster from loadbalancers. The source IP is this fix virtual IP of all albs."
  priority                                    = 156
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "*"
  source_port_range                           = "*"
  destination_port_range                      = "*"
  source_address_prefix                       = "168.63.129.16/32"
  destination_application_security_group_ids  = [azurerm_application_security_group.cluster.id]
  resource_group_name                         = var.out_platform_rg_name
  network_security_group_name                 = azurerm_network_security_group.cluster.name
}
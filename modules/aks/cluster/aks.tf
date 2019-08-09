resource "azurerm_kubernetes_cluster" "aks" {
  name                            = var.cluster_name
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  dns_prefix                      = "api-${var.cluster_name}"
  kubernetes_version              = var.aks_cluster_k8s_version
  node_resource_group             = "${var.platform_fqdn}_${var.aks_nodes_vm_prefix}s"
  tags                            = var.platform_resource_tags
  api_server_authorized_ip_ranges = "0.0.0.0/0"

  agent_pool_profile {
    name                          = var.aks_nodes_vm_prefix
    count                         = var.aks_nodes_amount
    vm_size                       = var.aks_nodes_vm_type
    os_type                       = "Linux"
    os_disk_size_gb               = var.aks_nodes_os_disk_size_gb
    type                          = "AvailabilitySet"
    max_pods                      = var.aks_nodes_max_pods
    vnet_subnet_id                = var.out_cluster_subnet_id
    //below params are needed to ensure terraform doesn't recreate the cluster when re-running apply
    node_taints                   = []
    enable_auto_scaling           = false
    min_count                     = 0
    max_count                     = 0
    availability_zones            = []
  }

  linux_profile {
    admin_username                = var.aks_nodes_admin_username

    ssh_key {
      key_data                    = file(var.aks_nodes_pub_key_controller_path)
    }
  }

  //todo create this with az cli
  service_principal {
    client_id                     = var.aks_cluster_k8s_serviceaccount_client_id
    client_secret                 = var.aks_cluster_k8s_serviceaccount_client_secret
  }

  role_based_access_control {
    enabled                       = true


    //idea: service principal used for terraform not enough permissions to see the service principal in AD ?
    //https://github.com/terraform-providers/terraform-provider-azuread/issues/4#issuecomment-407542721
    azure_active_directory {
      client_app_id               = var.aks_cluster_k8s_ad_client_app_id
      server_app_id               = var.aks_cluster_k8s_ad_server_app_id
      server_app_secret           = var.aks_cluster_k8s_ad_server_app_secret
//      tenant_id ="630b4926-3eee-47e5-b0c1-1dd833cb304a"
    }
  }

  addon_profile {

    http_application_routing {
      enabled                     = false
      //below param is needed to ensure terraform doesn't recreate the cluster when re-running apply
      http_application_routing_zone_name  = "DoesntMatter"
    }

    oms_agent {
      enabled                     = true
      log_analytics_workspace_id  = var.out_log_analytics_workspace_id
    }
  }

  network_profile {
    network_plugin                = "azure"
    network_policy                = "azure"
    dns_service_ip                = "10.100.0.10"
    docker_bridge_cidr            = "172.17.0.1/16"
    pod_cidr                      = "10.240.0.0/16"
    service_cidr                  = "10.100.0.0/16"
    load_balancer_sku             = "basic"

  }

  lifecycle {
    ignore_changes                = [
      "network_profile"
    ]
  }
}


resource "azurerm_kubernetes_cluster" "test" {
  name                            = var.cluster_name
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  dns_prefix                      = "api-${var.cluster_name}"
  kubernetes_version              = var.aks_cluster_k8s_version
  node_resource_group             = "${var.aks_nodes_vm_prefix}s.${var.cluster_domain}"
  tags                            = var.platform_resource_tags

  agent_pool_profile {
    name                          = var.aks_nodes_vm_prefix
    count                         = var.aks_nodes_amount
    vm_size                       = var.aks_nodes_vm_type
    os_type                       = "Linux"
    os_disk_size_gb               = var.aks_nodes_os_disk_size_gb
    type                          = "AvailabilitySet"
    max_pods                      = var.aks_nodes_max_pods
    vnet_subnet_id                = var.out_cluster_subnet_id
  }

  linux_profile {
    admin_username                = var.aks_nodes_admin_username

    ssh_key {
      key_data                    = file(var.aks_nodes_pub_key_controller_path)
    }
  }

  service_principal {
    client_id                     = var.cluster_k8s_serviceaccount_client_id
    client_secret                 = var.aks_cluster_k8s_serviceaccount_client_secret
  }

  role_based_access_control {
    enabled                       = true


//    todo
//    azure_active_directory {
//      # NOTE: in a Production environment these should be different values
//      # but for the purposes of this example, this should be sufficient
//      client_app_id = "${var.kubernetes_client_id}"
//
//      server_app_id     = "${var.kubernetes_client_id}"
//      server_app_secret = "${var.kubernetes_client_secret}"
//    }
  }

  addon_profile {

    http_application_routing {
      enabled                     = false
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


resource "azurerm_kubernetes_cluster" "test" {
  name                = var.platform_fqdn
  location            = var.platform_location
  resource_group_name = var.out_platform_rg_name
  dns_prefix          = "api-${var.cluster_name}"

  agent_pool_profile {
    name            = "${var.computenodes_vm_prefix}s.${var.cluster_domain}"
    count           = var.computenodes_amount
    vm_size         = var.computenodes_vm_type
    os_type         = "Linux"
    os_disk_size_gb = var.computenodes_os_disk_size_gb
    type            = "AvailabilitySet"
    max_pods        = 100
}

  agent_pool_profile {
    name            = "${var.infranodes_vm_prefix}s.${var.cluster_domain}"
    count           = var.infranodes_amount
    vm_size         = var.infranodes_vm_type
    os_type         = "Linux"
    os_disk_size_gb = var.infranodes_os_disk_size_gb
    type            = "AvailabilitySet"
    max_pods        = 100
  }

  linux_profile {
    admin_username = var.computenodes_admin_username

    ssh_key {
      key_data = file(var.computenodes_pub_key_controller_path)
    }
  }


  service_principal {
    client_id     = var.cluster_k8s_serviceaccount_client_id
    client_secret = var.cluster_k8s_serviceaccount_client_secret
  }

  role_based_access_control {
    enabled = true


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
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.out_log_analytics_workspace_id
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    dns_service_ip
    docker_bridge_cidr
pod_cidr
service_cidr
load_balancer_sku = "standard"

}


  tags            = var.platform_resource_tags
}
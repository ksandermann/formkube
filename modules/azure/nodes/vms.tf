resource "azurerm_virtual_machine" "computenodes" {
  count                             = var.computenodes_amount
  name                              = "${var.computenodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location                          = var.platform_location
  resource_group_name               = var.out_platform_rg_name
  network_interface_ids             = [var.out_computenodes_nics_ids[count.index]]
  vm_size                           = var.computenodes_vm_type
  //use modulo 3 as only regions with 3 av. zones are supported
  zones                             = [(count.index%3)+1]
  tags                              = var.platform_resource_tags
  delete_os_disk_on_termination     = true
  delete_data_disks_on_termination  = true

  //LRS for OS disks is sufficient as application data will be placed on seperate disks anyway
  storage_image_reference {
    publisher                       = var.computenodes_os_image_publisher
    offer                           = var.computenodes_os_image_offer
    sku                             = var.computenodes_os_image_sku
    version                         = var.computenodes_os_image_version
  }

  storage_os_disk {
    name                            = "${var.computenodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}-${var.computenodes_os_disk_suffix}"
    caching                         = "None"
    create_option                   = "FromImage"
    managed_disk_type               = var.computenodes_os_disk_type
    os_type                         = "Linux"
    disk_size_gb                    = var.computenodes_os_disk_size_gb
    write_accelerator_enabled       = false
  }

  os_profile {
    computer_name                   = "${var.computenodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    admin_username                  = var.computenodes_admin_username
    admin_password                  = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data                      = file(var.computenodes_pub_key_controller_path)
      path                          = "/home/${var.computenodes_admin_username}/.ssh/authorized_keys"
    }
  }
}


resource "azurerm_virtual_machine" "infranodes" {
  count                             = var.infranodes_amount
  name                              = "${var.infranodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location                          = var.platform_location
  resource_group_name               = var.out_platform_rg_name
  network_interface_ids             = [var.out_infranodes_nics_ids[count.index]]
  vm_size                           = var.infranodes_vm_type
  //use modulo 3 as only regions with 3 av. zones are supported
  zones                             = [(count.index%3)+1]
  tags                              = var.platform_resource_tags
  delete_os_disk_on_termination     = true
  delete_data_disks_on_termination  = true

  storage_image_reference {
    publisher                       = var.infranodes_os_image_publisher
    offer                           = var.infranodes_os_image_offer
    sku                             = var.infranodes_os_image_sku
    version                         = var.infranodes_os_image_version
  }

  //LRS for OS disks is sufficient as application data will be placed on seperate disks anyway
  storage_os_disk {
    name                            = "${var.infranodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}-${var.infranodes_os_disk_suffix}"
    caching                         = "None"
    create_option                   = "FromImage"
    managed_disk_type               = var.infranodes_os_disk_type
    os_type                         = "Linux"
    disk_size_gb                    = var.infranodes_os_disk_size_gb
  }

  os_profile {
    computer_name                   = "${var.infranodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    admin_username                  = var.infranodes_admin_username
    admin_password                  = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data                      = file(var.infranodes_pub_key_controller_path)
      path                          = "/home/${var.infranodes_admin_username}/.ssh/authorized_keys"
    }
  }
}
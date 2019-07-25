resource "azurerm_availability_set" "masters" {
  name                          = "${var.masters_vm_prefix}s.${var.cluster_fqdn}"
  location                      = var.platform_resource_tags
  resource_group_name           = var.out_platform_rg_name
  managed                       = true
  platform_fault_domain_count   = var.masters_fault_domains
  //more than 6 masters doesn't make sense
  platform_update_domain_count  = (var.masters_fault_domains > 1) ? 6 : 3
  tags                          = var.platform_resource_tags

}


resource "azurerm_virtual_machine" "masters" {
  count                             = var.masters_amount
  name                              = "${var.masters_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location                          = var.platform_location
  resource_group_name               = var.out_platform_rg_name
  network_interface_ids             = [var.out_masters_nics_ids[count.index]]
  vm_size                           = var.masters_vm_type
  tags                              = var.platform_resource_tags
  delete_os_disk_on_termination     = var.masters_os_disk_delete_on_destroy
  delete_data_disks_on_termination  = true
  availability_set_id               = azurerm_availability_set.masters.id

  //LRS for OS disks is sufficient as application data will be placed on seperate disks anyway
  storage_image_reference {
    publisher                       = var.masters_os_image_publisher
    offer                           = var.masters_os_image_offer
    sku                             = var.masters_os_image_sku
    version                         = var.masters_os_image_version
  }

  storage_os_disk {
    name                            = "${var.masters_vm_prefix}${count.index +1}.${var.cluster_fqdn}-${var.masters_os_disk_suffix}"
    caching                         = "None"
    create_option                   = "FromImage"
    managed_disk_type               = var.masters_os_disk_type
    os_type                         = "Linux"
    disk_size_gb                    = var.masters_os_disk_size_gb
    write_accelerator_enabled       = false
  }

  os_profile {
    computer_name                   = "${var.masters_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    admin_username                  = var.masters_admin_username
    admin_password                  = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data                      = file(var.masters_pub_key_controller_path)
      path                          = "/home/${var.masters_admin_username}/.ssh/authorized_keys"
    }
  }

  lifecycle {
    ignore_changes = [
      "storage_os_disk",
      "storage_data_disk",
    ]
  }
}
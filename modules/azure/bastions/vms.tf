resource "azurerm_virtual_machine" "bastions" {
  count                             = var.bastions_amount
  name                              = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location                          = var.cluster_location
  resource_group_name               = var.out_platform_rg_name
  network_interface_ids             = [var.out_bastions_subnet_nics_ids[count.index]]
  primary_network_interface_id      =  var.out_bastions_subnet_nics_ids[count.index]
  vm_size                           = var.bastions_vm_type
  //use modulo 3 as only regions with 3 av. zones are supported
  zones                             = [(count.index%3)+1]
  tags                              = var.cluster_resource_tags
  delete_os_disk_on_termination     = true
  delete_data_disks_on_termination  = true

  //LRS for OS disks is sufficient as bastion functionality is not crucial for cluster operations
  storage_image_reference {
    publisher                       = var.bastions_os_image_publisher
    offer                           = var.bastions_os_image_offer
    sku                             = var.bastions_os_image_sku
    version                         = var.bastions_os_image_version
  }

  storage_os_disk {
    name                            = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}-${var.bastions_os_disk_suffix}"
    create_option                   = "FromImage"
    os_type                         = "Linux"
    disk_size_gb                    = var.bastions_os_disk_size_gb
    vhd_uri                         = var.bastion_vhd_uri
  }

  os_profile {
    computer_name                   = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    admin_username                  = var.bastions_admin_username
    admin_password                  = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data                      = file(var.bastions_pub_key_controller_path)
      path                          = "/home/${var.bastions_admin_username}/.ssh/authorized_keys"
    }
  }
}
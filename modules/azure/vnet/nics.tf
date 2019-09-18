resource "azurerm_network_interface" "bastions" {
  count                           = var.bastions_amount
  name                            = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  network_security_group_id       = azurerm_network_security_group.bastions.id
  enable_ip_forwarding            = true
  enable_accelerated_networking   = "false"
  //dns servers can not be set here as azurerm_dns_zone does not return DNS servers as IPs. This is not an issue as we are using a public DNS zone anyway.
  tags                            = var.platform_resource_tags

  ip_configuration {
    name                          = "${var.bastions_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    primary                       = true
    subnet_id                     = azurerm_subnet.bastions.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    //bastions start with IP 10 in subnet
    private_ip_address            = cidrhost(var.platform_network_bastion_subnet_CIDR, count.index + 10 )
    public_ip_address_id          = azurerm_public_ip.bastions.*.id[count.index]
  }
}

resource "azurerm_network_interface" "masters" {
  count                           = var.masters_amount
  name                            = "${var.masters_vm_prefix}${count.index + 1}.${var.cluster_fqdn}"
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  network_security_group_id       = azurerm_network_security_group.cluster.id
  enable_ip_forwarding            = true
  enable_accelerated_networking   = "false"
  tags                            = var.platform_resource_tags

  ip_configuration {
    name                          = "${var.masters_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    primary                       = "true"
    subnet_id                     = azurerm_subnet.cluster.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    //masters start with IP 10 in subnet
    private_ip_address            = cidrhost(var.platform_network_cluster_subnet_CIDR, count.index + 10)
  }
}

resource "azurerm_network_interface" "computenodes" {
  count                           = var.computenodes_amount
  name                            = "${var.computenodes_vm_prefix}${count.index + 1}.${var.cluster_fqdn}"
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  network_security_group_id       = azurerm_network_security_group.cluster.id
  enable_ip_forwarding            = true
  enable_accelerated_networking   = "false"
  tags                            = var.platform_resource_tags

  ip_configuration {
    name                          = "${var.computenodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    primary                       = "true"
    subnet_id                     = azurerm_subnet.cluster.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    //computenodes start with IP 100 in the subnet
    private_ip_address            = cidrhost(var.platform_network_cluster_subnet_CIDR, count.index + 100)
  }
}

resource "azurerm_network_interface" "infranodes" {
  count                             = var.infranodes_amount
  name                              = "${var.infranodes_vm_prefix}${count.index + 1}.${var.cluster_fqdn}"
  location                          = var.platform_location
  resource_group_name               = var.out_platform_rg_name
  network_security_group_id         = azurerm_network_security_group.cluster.id
  enable_ip_forwarding              = true
  enable_accelerated_networking     = "false"
  tags                              = var.platform_resource_tags

  ip_configuration {
    name                            = "${var.infranodes_vm_prefix}${count.index +1}.${var.cluster_fqdn}"
    primary                         = "true"
    subnet_id                       = azurerm_subnet.cluster.id
    private_ip_address_allocation   = "Static"
    private_ip_address_version      = "IPv4"
    //infranodes start with IP 200 in the subnet
    private_ip_address              = cidrhost(var.platform_network_cluster_subnet_CIDR, count.index + 200)
  }
}

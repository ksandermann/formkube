output "out_loadbalancer_public_ip" {
  value = azurerm_public_ip.loadbalancer.ip_address
}
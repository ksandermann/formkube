//empty route-table to support azure cloud provider 'routeTableName'
//https://github.com/kubernetes/cloud-provider-azure/blob/master/docs/cloud-provider-config.md#cluster-config
resource "azurerm_route_table" "cluster" {
  name                            = "cluster.${var.cluster_fqdn}"
  location                        = var.platform_location
  resource_group_name             = var.out_platform_rg_name
  disable_bgp_route_propagation   = false
  tags                            = var.platform_resource_tags
}

resource "azurerm_subnet_route_table_association" "cluster" {
  subnet_id                       = azurerm_subnet.cluster.id
  route_table_id                  = azurerm_route_table.cluster.id
  depends_on                      = [azurerm_subnet.cluster, azurerm_route_table.cluster]
}
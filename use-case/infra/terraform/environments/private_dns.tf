resource "azurerm_private_dns_zone" "pdns" {
  name                = "${var.environment}.${var.project}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdns-vnet-link" {
  name                  = "${azurerm_virtual_network.vnet.name}.com"
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.pdns.name
  depends_on = [
    azurerm_subnet.snet_psql
  ]
}
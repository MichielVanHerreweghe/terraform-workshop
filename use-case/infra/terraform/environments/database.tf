resource "azurerm_postgresql_flexible_server" "psql" {
  name                          = "psql-${var.project}-${var.location_short_name}-${var.environment}"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg.name
  version                       = "12"
  delegated_subnet_id           = azurerm_subnet.snet_psql.id
  public_network_access_enabled = false
  administrator_login           = var.psql_administrator_login
  administrator_password        = var.psql_administrator_password
  zone                          = var.psql_zone
  storage_mb                    = var.psql_storage_mb
  storage_tier                  = var.psql_storage_tier
  private_dns_zone_id           = azurerm_private_dns_zone.pdns.id
  sku_name                      = var.psql_storage_sku
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.pdns-vnet-link
  ]
}
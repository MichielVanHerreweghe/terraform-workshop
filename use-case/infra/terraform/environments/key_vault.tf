data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                      = "kv-${var.project}-${var.location_short_name}-${var.environment}"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  sku_name                  = var.kv_sku
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = true
  purge_protection_enabled  = var.environment == "dev" ? false : true
}

resource "azurerm_key_vault_secret" "kv_secret_appi_connection" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "ApplicationInsights--ConnectionString"
  value        = azurerm_application_insights.appi.connection_string
}

resource "azurerm_key_vault_secret" "kv_secret_db_connection" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "ConnectionStrings--Database"
  value        = "Server=${azurerm_postgresql_flexible_server.psql.fqdn};Database=Database=${var.psql_database_name};Port=5432;Username=${azurerm_postgresql_flexible_server.psql.administrator_login};Password=${azurerm_postgresql_flexible_server.psql.administrator_password};Ssl Mode=Require;"
}
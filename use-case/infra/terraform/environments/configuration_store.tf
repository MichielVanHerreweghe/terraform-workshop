resource "azurerm_user_assigned_identity" "id_appcs" {
  name                = "id-appcs-${var.project}-${var.location_short_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "id_appcs_keyvaultreader" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.id_appcs.principal_id

}

resource "azurerm_role_assignment" "id_appcs_keyvaultsecretsuser" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.id_appcs.principal_id
}

resource "azurerm_app_configuration" "appcs" {
  name                  = "appcs-${var.project}-${var.location_short_name}-${var.environment}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  sku                   = var.appcs_sku
  local_auth_enabled    = var.environment == "dev" ? true : false
  public_network_access = "Enabled"

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.id_appcs.id
    ]
  }
}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = azurerm_app_configuration.appcs.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}


resource "azurerm_app_configuration_key" "appcs_key_appi_connection" {
  configuration_store_id = azurerm_app_configuration.appcs.id
  key                    = "ApplicationInsights:ConnectionString"
  type                   = "vault"
  vault_key_reference    = azurerm_key_vault_secret.kv_secret_appi_connection.versionless_id
    depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}

resource "azurerm_app_configuration_key" "appcs_key_db_connection" {
  configuration_store_id = azurerm_app_configuration.appcs.id
  key                    = "ConnectionStrings:Database"
  type                   = "vault"
  vault_key_reference    = azurerm_key_vault_secret.kv_secret_db_connection.versionless_id
    depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}
resource "azurerm_log_analytics_workspace" "log" {
  name                = "log-${var.project}-${var.location_short_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.log_sku
}

resource "azurerm_application_insights" "appi" {
  name                = "appi-${var.project}-${var.location_short_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.log.id
}
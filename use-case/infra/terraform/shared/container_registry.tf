resource "azurerm_container_registry" "cr" {
  name                = "cr${replace(var.project, "-", "")}${var.location_short_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.cr_sku
  admin_enabled       = var.cr_admin_enabled
}
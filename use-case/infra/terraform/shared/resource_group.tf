resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}-${var.location_short_name}-shared"
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}-${var.location_short_name}-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_prefixes
}

resource "azurerm_subnet" "snet_vm" {
  name                 = "snet-vms-${var.project}-${var.location_short_name}-shared"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_vm_address_prefixes
}
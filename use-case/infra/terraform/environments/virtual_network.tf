data "azurerm_virtual_network" "vnet_shared" {
  name                = var.vnet_shared_name
  resource_group_name = var.rg_shared_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}-${var.location_short_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_prefixes
}

resource "azurerm_subnet" "snet_psql" {
  name                 = "snet-psql-${var.project}-${var.location_short_name}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_psql_address_prefixes

  delegation {
    name = "delegation-snet-psql-${var.project}-${var.location_short_name}-${var.environment}"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_subnet" "snet_cae" {
  name                 = "snet-cae-${var.project}-${var.location_short_name}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_cae_address_prefixes

  delegation {
    name = "delegation-snet-cae-${var.project}-${var.location_short_name}-${var.environment}"

    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_virtual_network_peering" "environment_to_shared" {
  name                      = "peer-${var.environment}-to-shared"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_shared.id
}

resource "azurerm_virtual_network_peering" "shared_to_environment" {
  name                      = "peer-shared-to-${var.environment}"
  resource_group_name       = var.rg_shared_name
  virtual_network_name      = data.azurerm_virtual_network.vnet_shared.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
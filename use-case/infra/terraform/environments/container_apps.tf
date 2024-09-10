data "azurerm_container_registry" "cr" {
  name                = var.cr_name
  resource_group_name = var.rg_shared_name
}

resource "azurerm_user_assigned_identity" "id_cae" {
  name                = "id-cae-${var.project}-${var.location_short_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "id_cae_acrpull" {
  name                 = uuid()
  scope                = data.azurerm_container_registry.cr.id
  principal_id         = azurerm_user_assigned_identity.id_cae.principal_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "AcrPull"
}

resource "azurerm_container_app_environment" "cae" {
  name                               = "cae-${var.project}-${var.location_short_name}-${var.environment}"
  location                           = var.location
  resource_group_name                = azurerm_resource_group.rg.name
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.log.id
  infrastructure_resource_group_name = "MC_cae-${var.project}-${var.location_short_name}-${var.environment}"
  infrastructure_subnet_id           = azurerm_subnet.snet_cae.id

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}

resource "azurerm_container_app" "ca_backend" {
  name                         = "ca-backend-${var.project}-${var.location_short_name}-${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  revision_mode                = var.ca_backend_revision_mode

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.id_cae.id
    ]
  }

  template {
    container {
      name   = var.ca_backend_name
      image  = var.ca_backend_image
      cpu    = var.ca_backend_cpu
      memory = var.ca_backend_memory
    }
  }
}

resource "azurerm_container_app" "ca_frontend" {
  name                         = "ca-frontend-${var.project}-${var.location_short_name}-${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  revision_mode                = var.ca_frontend_revision_mode

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.id_cae.id
    ]
  }

  template {
    container {
      name   = var.ca_frontend_name
      image  = var.ca_frontend_image
      cpu    = var.ca_frontend_cpu
      memory = var.ca_frontend_memory
    }
  }
}
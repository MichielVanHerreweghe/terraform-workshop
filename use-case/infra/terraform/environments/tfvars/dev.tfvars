project = "poab-demo"
location = "northeurope"
location_short_name = "ne"
environment = "dev"

vnet_shared_name = "vnet-poab-demo-ne-shared"
rg_shared_name = "rg-poab-demo-ne-shared"
cr_name = "crpoabdemone"

vnet_address_prefixes = [
    "10.1.0.0/24"
]
snet_psql_address_prefixes = [
    "10.1.0.0/27"
]
snet_cae_address_prefixes = [
    "10.1.0.32/27"
]

psql_administrator_login = "poabadmin"
psql_administrator_password = "SuperS3cur3P@ssword!"
psql_zone = "1"
psql_storage_mb = 32768
psql_storage_tier = "P30"
psql_storage_sku = "GP_Standard_D4s_v3"
psql_database_name = "poabdemo"

log_sku = "PerGB2018"

ca_backend_revision_mode = "Single"
ca_backend_name = "backend"
ca_backend_image = "crpoabdemone.azurecr.io/backend:latest"
ca_backend_cpu = 1
ca_backend_memory = "2Gi"
ca_backend_target_port = 8080
ca_backend_exposed_port = 8080
ca_backend_external_enabled = true

kv_sku = "standard"

appcs_sku = "free"
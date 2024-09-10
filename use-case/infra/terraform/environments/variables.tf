# General #
variable "project" {
  type        = string
  description = "The project name"
}

variable "location" {
  type        = string
  description = "The location where the resources will be deployed"
}

variable "location_short_name" {
  type        = string
  description = "The short name of the location"
}

variable "environment" {
  type        = string
  description = "The environment where the resources will be deployed"
}

# Existing Resources #

variable "vnet_shared_name" {
  type        = string
  description = "The name of the shared virtual network"
}

variable "rg_shared_name" {
  type        = string
  description = "The name of the shared resource group"
}

variable "cr_name" {
  type        = string
  description = "The name of the container registry"
}

# Virtual Network #
variable "vnet_address_prefixes" {
  type        = list(string)
  description = "The address space that is used by the virtual network"
}

variable "snet_psql_address_prefixes" {
  type        = list(string)
  description = "The address space that is used by the subnet"
}

variable "snet_cae_address_prefixes" {
  type        = list(string)
  description = "The address space that is used by the subnet"
}

# Database #
variable "psql_administrator_login" {
  type        = string
  description = "The administrator login for the PostgreSQL server"
}

variable "psql_administrator_password" {
  type        = string
  description = "The administrator password for the PostgreSQL server"
  sensitive   = true
}

variable "psql_zone" {
  type        = string
  description = "The zone for the PostgreSQL server"
}

variable "psql_storage_mb" {
  type        = number
  description = "The storage capacity of the PostgreSQL server in MB"
}

variable "psql_storage_tier" {
  type        = string
  description = "The storage tier of the PostgreSQL server"
}

variable "psql_storage_sku" {
  type        = string
  description = "The storage SKU of the PostgreSQL server"
}

variable "psql_database_name" {
  type        = string
  description = "The name of the PostgreSQL database"
}

# Application Insights #
variable "log_sku" {
  type        = string
  description = "The SKU of the Log Analytics workspace"
}

# Container Apps #
variable "ca_backend_revision_mode" {
  type        = string
  description = "The revision mode of the container app"
}

variable "ca_backend_name" {
  type        = string
  description = "The name of the container"
}

variable "ca_backend_image" {
  type        = string
  description = "The image of the container app"
}

variable "ca_backend_cpu" {
  type        = number
  description = "The CPU of the container app"
}

variable "ca_backend_memory" {
  type        = string
  description = "The memory of the container app"
}

variable "ca_frontend_revision_mode" {
  type        = string
  description = "The revision mode of the container app"
}

variable "ca_frontend_name" {
  type        = string
  description = "The name of the container"
}

variable "ca_frontend_image" {
  type        = string
  description = "The image of the container app"
}

variable "ca_frontend_cpu" {
  type        = number
  description = "The CPU of the container app"
}

variable "ca_frontend_memory" {
  type        = string
  description = "The memory of the container app"
}

# Key Vault #
variable "kv_sku" {
  type        = string
  description = "The SKU of the key vault"
}

# Configuration Store #
variable "appcs_sku" {
  type        = string
  description = "The SKU of the configuration store"
}
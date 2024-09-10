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

# Virtual Network #
variable "vnet_address_prefixes" {
  type        = list(string)
  description = "The address space that is used by the virtual network"
}

variable "snet_vm_address_prefixes" {
  type        = list(string)
  description = "The address space that is used by the subnet"
}

# Jumphost #
variable "jumphost_vm_size" {
  type        = string
  description = "The size of the jumphost VM"
}

variable "jumphost_vm_admin_username" {
  type        = string
  description = "The admin username of the jumphost VM"
}

variable "jumphost_vm_admin_password" {
  type        = string
  description = "The admin password of the jumphost VM"
  sensitive   = true
}

# Container Registry #
variable "cr_sku" {
  type        = string
  description = "The SKU of the Container Registry"
}

variable "cr_admin_enabled" {
  type        = bool
  description = "Enable admin user for the Container Registry"
}
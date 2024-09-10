terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }

  backend "azurerm" {

  }
}

provider "azure" {
  features {}
  subscription_id = "2b22d58f-b265-48e2-8341-e0f2afc6610c"
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "local" {}

terraform {
  required_version = ">= 0.12.25"
  backend "azurerm" {
  }
  required_providers {
    azurerm = "~> 2.17.0"
  }
}

provider "azurerm" {
  version = "2.17.0"
  features {}
}
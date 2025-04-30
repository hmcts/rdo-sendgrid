terraform {
  required_version = ">= 1.9"
  backend "azurerm" {
  }
  required_providers {
    azurerm = "~> 4.26.0"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  alias = "atlassian_sendgrid"
  features {}
  # It is not possible to conditionally create a provider block in terraform
  # So to avoid permission errors when this provider attempts to fetch resources in Atlassian LVE subscription when nonprod stage runs
  # every subscription ID is passed even though this whole provider is redundant in such case
  subscription_id = var.subscription_id
}
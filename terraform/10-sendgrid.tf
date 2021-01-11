data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${"SendGrid-"}${var.env}"
  location = "uksouth"
}


resource "azurerm_template_deployment" "sendgrid" {
  for_each = var.configs

  name                = "${each.key}-sendgrid"
  resource_group_name = azurerm_resource_group.rg.name
  template_body = file("sendgrid_template.json")

  parameters = {
    name                  = "${each.key}-${var.env}"
    location              = azurerm_resource_group.rg.location
    plan_name             = each.value.plan_name
    plan_publisher        = "Sendgrid"
    plan_product          = "sendgrid_azure"
    plan_promotion_code   = ""
    password              = random_password.password[each.key].result
    acceptMarketingEmails = 0
    email                 = "DTSPlatformOps@HMCTS.NET"
    firstName             = "Platform"
    lastName              = "Operations"
    company               = "HMCTS"
    website               = "https://www.gov.uk/"
  }

  deployment_mode = "incremental"
}

resource "random_password" "password" {
  for_each = var.configs

  length           = 16
  special          = true
  override_special = "_%@"
}


resource "azurerm_key_vault_secret" "secret" {
  for_each = var.configs

  name         = "${each.key}-password"
  value        = random_password.password[each.key].result
  key_vault_id = azurerm_key_vault.keyvault.id
}


resource "azurerm_key_vault" "keyvault" {
  name                     = "${"sendgrid"}${var.env}"
  location                 = "uksouth"
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled      = true
  purge_protection_enabled = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get", "create", "list"
    ]

    secret_permissions = [
      "get", "set", "list", "delete", "recover"
    ]

    storage_permissions = [
      "get", "set", "list"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "300e771f-856c-45cc-b899-40d78281e9c1"

    key_permissions = [
      "get", "create", "list"
    ]

    secret_permissions = [
      "get", "set", "list"
    ]

    storage_permissions = [
      "get", "set", "list"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "e7ea2042-4ced-45dd-8ae3-e051c6551789"

    key_permissions = [
      "get", "create", "list"
    ]

    secret_permissions = [
      "get", "set", "list"
    ]

    storage_permissions = [
      "get", "set", "list"
    ]
  }
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "ca6d5085-485a-417d-8480-c3cefa29df31"

    key_permissions = [
      "get", "create", "list"
    ]

    secret_permissions = [
      "get", "set", "list"
    ]

    storage_permissions = [
      "get", "set", "list"
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

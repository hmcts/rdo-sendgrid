data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${"SendGrid-"}${var.env}"
  location = "uksouth"
  tags = var.tags
}

resource "azurerm_resource_group_template_deployment" "sendgrid" {
  for_each = var.configs

  name                = "${each.key}-sendgrid"
  resource_group_name = azurerm_resource_group.rg.name
  template_content    = file("./templates/sendgrid_saas.json")

  parameters_content = jsonencode({
    name = {
      value = "${each.key}-${var.env}"
    }
    planId = {
      value = each.value.plan_name
    }
    termId = {
      value = var.sendgrid_saas_term_id
    }
    azureSubscriptionId = {
      value = var.subscription_id
    }
    autoRenew = {
      value = true
    }
    storeFront = {
      value = "DevServiceMigration"
    }
    tags = {
      value = merge(var.tags, { application = "${each.value.application_tag}" })
    }
  })

  deployment_mode = "Incremental"
  tags = var.tags
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
  tags = var.tags
}

resource "azurerm_key_vault" "keyvault" {
  name                     = "${"sendgrid"}${var.env}"
  location                 = "uksouth"
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = true

  sku_name = "standard"

  dynamic "access_policy" {
    for_each = var.keyvault_policies
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = access_policy.value["object_id"]

      key_permissions = access_policy.value["key_permissions"]
      secret_permissions = access_policy.value["secret_permissions"]
      certificate_permissions = access_policy.value["certificate_permissions"]
      storage_permissions = access_policy.value["storage_permissions"]
    }
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

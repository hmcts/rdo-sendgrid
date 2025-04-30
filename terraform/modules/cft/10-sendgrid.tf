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
  template_content    = file("./modules/cft/sendgrid_template.json")

  parameters_content = jsonencode({
    name                  = {
      value = "${each.key}-${var.env}"
    }
    location              = {
      value = azurerm_resource_group.rg.location
    }
    plan_name             = {
      value = each.value.plan_name
    }
    plan_publisher        = {
      value = "Sendgrid"
    }
    plan_product          = {
      value = "sendgrid_azure"
    }
    plan_promotion_code   = {
      value = ""
    }
    # Note: Even when there is no changes the provider will still show change due to SecureString being used
    # https://github.com/hashicorp/terraform-provider-azurerm/issues/15394
    password              = {
      value = random_password.password[each.key].result
    }
    acceptMarketingEmails = {
      value = "0"
    }
    email                 = {
      value = "DTSPlatformOps@HMCTS.NET"
    }
    firstName             = {
      value = "Platform"
    }
    lastName              = {
      value = "Operations"
    }
    company               = {
      value = "HMCTS"
    }
    website               = {
      value = "https://www.gov.uk/"
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

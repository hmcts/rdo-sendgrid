data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${"SendGrid-"}${var.env}"
  location = "uksouth"
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
    # Note: There is no changes but the provider will still show change due to SecureString being used
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

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "29e4829a-6912-4285-8573-0afd9c5b70d8"

  #   key_permissions = [
  #     "Get", "List", "Update"
  #   ]

  #   secret_permissions = [
  #     "Get", "List", "Set", "Delete", "Recover"
  #   ]

  #   storage_permissions = [
  #     "Get", "Set", "List"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azurerm_client_config.current.object_id

  #   key_permissions = [
  #     "Get", "List", "Update"
  #   ]

  #   secret_permissions = [
  #     "Get", "List", "Set", "Delete", "Recover"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "b2a1773c-a5ae-48b5-b5fa-95b0e05eee05"

  #   secret_permissions = [
  #     "List", "Get"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "e7ea2042-4ced-45dd-8ae3-e051c6551789"

  #   certificate_permissions = [
  #     "Get",
  #     "List",
  #     "Update",
  #     "Create",
  #     "Import",
  #     "Delete",
  #     "Recover",
  #     "Backup",
  #     "Restore",
  #     "ManageContacts",
  #     "ManageIssuers",
  #     "GetIssuers",
  #     "ListIssuers",
  #     "SetIssuers",
  #     "DeleteIssuers"
  #   ]

  #   key_permissions = [
  #     "Get",
  #     "List",
  #     "Update",
  #     "Create",
  #     "Import",
  #     "Delete",
  #     "Recover",
  #     "Backup",
  #     "Restore"
  #   ]

  #   secret_permissions = [
  #     "Get",
  #     "List",
  #     "Set",
  #     "Delete",
  #     "Recover",
  #     "Backup",
  #     "Restore",
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "8c1aee83-cb99-4a35-a8cf-27019733392d"

  #   certificate_permissions = []

  #   key_permissions = [
  #     "Get",
  #     "Create",
  #     "List"
  #   ]
    
  #   secret_permissions = [
  #     "Get",
  #     "Set",
  #     "List",
  #     "Delete",
  #     "Recover"
  #   ]

  #   storage_permissions = [
  #     "Get",
  #     "Set",
  #     "List"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "ca6d5085-485a-417d-8480-c3cefa29df31"

  #   key_permissions = [
  #     "Get", "Create", "List"
  #   ]

  #   secret_permissions = [
  #     "Get", "Set", "List"
  #   ]

  #   storage_permissions = [
  #     "Get", "Set", "List"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "57128619-2c09-4b9b-80b8-322ceff22141"

  #   key_permissions = [
  #     "Get", "Create", "List"
  #   ]

  #   secret_permissions = [
  #     "Get", "Set", "List", "Delete", "Recover"
  #   ]

  #   storage_permissions = [
  #     "Get", "Set", "List"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "3e1c4905-21f5-47c8-9562-402001ada9b4"

  #   key_permissions = [
  #     "Get", "List", "Update", "Create"
  #   ]

  #   secret_permissions = [
  #     "Get", "List", "Set", "Delete", "Purge"
  #   ]

  #   storage_permissions = []
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "6ddb97a3-eed0-4d86-b3ec-c2430df55d7a"

  #   key_permissions = [
  #     "Get", "List", "Update"
  #   ]

  #   secret_permissions = [
  #     "Get", "List", "Set", "Delete"
  #   ]

  #   storage_permissions = []
  # }
  
  ######

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "300e771f-856c-45cc-b899-40d78281e9c1"

  #   key_permissions = [
  #     "Get", "Create", "List"
  #   ]

  #   secret_permissions = [
  #     "Get", "Set", "List"
  #   ]

  #   storage_permissions = [
  #     "Get", "Set", "List"
  #   ]
  # }

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = "c36eaede-a0ae-4967-8fed-0a02960b1370"

  #   key_permissions = [
  #     "Get", "Create", "List"
  #   ]

  #   secret_permissions = [
  #     "Get", "Set", "List"
  #   ]

  #   storage_permissions = [
  #     "Get", "Set", "List"
  #   ]
  # }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

env             = "prod"
subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1" # DCD-CNP-PROD
product         = "core-infra"
businessArea    = "Cross-Cutting"

cft_subaccount_configs = {
  "cmc" = {
    plan_name       = "essentials-50k"
    application_tag = "civil-money-claims"
  },
  "fpl" = {
    plan_name       = "pro-100k"
    application_tag = "family-public-law"
  },
  "sscs2" = {
    plan_name       = "essentials-50k"
    application_tag = "social-service-child-support"
  }
}

cft_keyvault_policies = {
  "01" = {
    object_id               = "b7a68ebf-8ace-4855-9ea6-1f08ef0af8f9"
    certificate_permissions = []
    key_permissions = [
      "List", "Get", "Update", "Import", "Create"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge"
    ]
    storage_permissions = []
  },
  "10" = {
    object_id = "4d0554dd-fe60-424a-be9c-36636826d927"
    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers"
    ]
    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
    storage_permissions = []
  },
  "20" = {
    object_id               = "e2ad93bc-4655-4801-8100-8ed155b0698c"
    certificate_permissions = []
    key_permissions = [
      "Get",
      "Create",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Recover",
    ]
    storage_permissions = [
      "Get",
      "Set",
      "List"
    ]
  },
  "30" = {
    object_id               = "ca6d5085-485a-417d-8480-c3cefa29df31"
    certificate_permissions = []
    key_permissions = [
      "Get",
      "Create",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]
    storage_permissions = [
      "Get",
      "Set",
      "List"
    ]
  },
  "40" = {
    object_id               = "57128619-2c09-4b9b-80b8-322ceff22141"
    certificate_permissions = []
    key_permissions = [
      "Get",
      "Create",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Recover"
    ]
    storage_permissions = [
      "Get",
      "Set",
      "List"
    ]
  },
  "50" = {
    object_id               = "626041d7-1bf3-46ca-84b6-28b6b0c60efe"
    certificate_permissions = []
    key_permissions         = []

    secret_permissions = [
      "List",
      "Get"
    ]
    storage_permissions = []
  },
  "60" = {
    object_id = "92515ab5-7d61-45f1-9db0-a419e72a0d0b"
    certificate_permissions = [
      "Get",
      "List"
    ]
    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List"
    ]
    storage_permissions = []
  },
  "70" = {
    object_id               = "6be941b3-d610-4f7a-95ed-2da328c90757"
    certificate_permissions = []
    key_permissions = [
      "Get",
      "List",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
    storage_permissions = []
  }
}
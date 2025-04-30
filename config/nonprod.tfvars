env             = "nonprod"
subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9" # DCD-CNP-DEV
product         = "core-infra"
businessArea    = "Cross-Cutting"

cft_subaccount_configs = {
  "cmc" = {
    plan_name       = "essentials-50k"
    application_tag = "civil-money-claims"
  },
  "fpl" = {
    plan_name       = "essentials-50k"
    application_tag = "family-public-law"
  }
}

# Map keys are sorted to ensure provider API consistently returns the same order
# so that no superficial changes are shown on the plan when using dynamic block
cft_keyvault_policies = {
  "01" = {
    object_id               = "29e4829a-6912-4285-8573-0afd9c5b70d8"
    certificate_permissions = []
    key_permissions = [
      "Get", "List", "Update"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover"
    ]
    storage_permissions = []
  },
  "10" = {
    object_id               = "b2a1773c-a5ae-48b5-b5fa-95b0e05eee05"
    certificate_permissions = []
    key_permissions         = []

    secret_permissions = [
      "List", "Get"
    ]

    storage_permissions = []
  },
  "20" = {
    object_id = "e7ea2042-4ced-45dd-8ae3-e051c6551789"
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
      "Restore",
    ]
    storage_permissions = []
  },
  "30" = {
    object_id               = "8c1aee83-cb99-4a35-a8cf-27019733392d"
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
  "40" = {
    object_id               = "ca6d5085-485a-417d-8480-c3cefa29df31"
    certificate_permissions = []
    key_permissions = [
      "Get", "Create", "List"
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    storage_permissions = [
      "Get", "Set", "List"
    ]
  },
  "50" = {
    object_id               = "57128619-2c09-4b9b-80b8-322ceff22141"
    certificate_permissions = []
    key_permissions = [
      "Get", "Create", "List"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Recover"
    ]

    storage_permissions = [
      "Get", "Set", "List"
    ]
  },
  "60" = {
    object_id               = "3e1c4905-21f5-47c8-9562-402001ada9b4"
    certificate_permissions = []
    key_permissions = [
      "Get", "List", "Update", "Create"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge"
    ]

    storage_permissions = []
  },
  "70" = {
    object_id               = "6ddb97a3-eed0-4d86-b3ec-c2430df55d7a"
    certificate_permissions = []
    key_permissions = [
      "Get", "List", "Update"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]

    storage_permissions = []
  }
}


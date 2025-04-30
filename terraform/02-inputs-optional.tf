variable "cft_subaccount_configs" {
  description = "SendGrid subaccount configuration map for CFT"
  type = map(object({
    plan_name       = string
    application_tag = string
  }))
  default = {}
}

variable "cft_keyvault_policies" {
  description = "Key Vault policies for SendGrid"
  type = map(object({
    object_id               = string
    certificate_permissions = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    storage_permissions     = list(string)
  }))
  default = {}
}

variable "atlassian_sendgrid_config" {
  description = "SendGrid configuration for Atlassian"
  type = object({
    existing_sendgrid_deployment_tpl_id = string
    sendgrid_deployment_tpl_name        = string
    resource_group_name                 = string
    sendgrid_account_name               = string
    sendgrid_plan_name                  = string
  })
  default = null
}
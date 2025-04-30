variable "configs" {
  description = "Map of configurations for each of the SendGrid sub-accounts"
  type = map(object({
    plan_name       = string
    application_tag = string
  }))
}

variable "env" {
  description = "Current environment (nonprod/prod)"
  type        = string
}

variable "keyvault_policies" {
  description = "A set of Key Vault policies to set on the Keyvault associated with SendGrid secrets"
  type = map(object({
    object_id          = string
    certificate_permissions  = list(string)
    key_permissions   = list(string)
    secret_permissions = list(string)
    storage_permissions = list(string)
  }))
}

variable "subscription_id" {
  description = "Subscription ID where the SendGrid account is deployed"
  type        = string 
}

variable "sendgrid_saas_term_id" {
  description = "SendGrid SaaS term ID - this is the term ID that is used in the marketplace"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type        = map(string)
}
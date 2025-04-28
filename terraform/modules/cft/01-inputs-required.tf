variable "configs" {
  description = "SendGrid Configuration"
  type = map(object({
    plan_name       = string
  }))
}

variable "env" {
  description = "SendGrid Configuration"
  type        = string
}

variable "keyvault_policies" {
  description = "Key Vault policies for SendGrid"
  type = map(object({
    object_id          = string
    certificate_permissions  = list(string)
    key_permissions   = list(string)
    secret_permissions = list(string)
    storage_permissions = list(string)
  }))
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type        = map(string)
}
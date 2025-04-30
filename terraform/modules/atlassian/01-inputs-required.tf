variable "sendgrid_deployment_tpl_name" {
  description = "SendGrid deployment template name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the SendGrid account is deployed"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID where the SendGrid account is deployed"
  type        = string
}

variable "sendgrid_account_name" {
  description = "SendGrid account name"
  type        = string
}

variable "sendgrid_plan_name" {
  description = "SendGrid plan name"
  type        = string
}

variable "sendgrid_offer_id" {
  description = "SendGrid offer ID - this is the offer ID that is used in the marketplace"
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
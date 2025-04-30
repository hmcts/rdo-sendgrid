variable "env" {
  description = "Environment"
  type        = string
}

variable "product" {
  description = "Product"
  type        = string
}

variable "builtFrom" {
  description = "Address of this repository"
  type        = string
  default     = "https://github.com/hmcts/rdo-sendgrid"
}

variable "businessArea" {
  description = "Business Area (e.g. Cross-Cutting)"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID where the resources are deployed"
  type        = string
}

# This value must be copied from the initial click-ops deployment as described below
# https://learn.microsoft.com/en-us/marketplace/programmatic-deploy-of-marketplace-products#saas-offer-from-azure-marketplace
variable "sendgrid_saas_term_id" {
  description = "SendGrid SaaS term ID - this value must be fetched after initial deployment through ClickOps"
  type        = string
  default     = "gmz7xq9ge3py"
}
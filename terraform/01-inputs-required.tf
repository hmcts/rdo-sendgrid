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
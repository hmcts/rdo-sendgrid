resource "azurerm_template_deployment" "private_endpoint" {
  for_each = var.configs

  name                = each.name-sendgrid
  resource_group_name = SendGrid-var.env

  template_body = file("sendgrid_template.json")

  parameters = {
    name                  = each.name
    location              = "uksouth"
    tags                  = ""
    plan_name             = each.plan_name
    plan_publisher        = Sendgrid
    plan_product          = sendgrid_azure
    plan_promotion_code   = ""
    password              = random_password.password
    acceptMarketingEmails = 0
    email                 = "Zulfikar.bharmal@hmcts.net"
    firstName             = Zulfikar
    lastName              = Bharmal
    company               = HMCTS
    website               = "https://www.gov.uk/"
  }

  deployment_mode = "Incremental"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
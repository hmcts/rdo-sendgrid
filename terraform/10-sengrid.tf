resource "azurerm_template_deployment" "private_endpoint" {
  name                = "${local.account_name}-sendgrid"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  template_body = file("sendgrid_template.json")

  parameters = {
    name                  = ""
    location              = ""
    tags                  = ""
    plan_name             = ""
    plan_publisher        = ""
    plan_product          = ""
    plan_promotion_code   = ""
    password              = ""
    acceptMarketingEmails = ""
    email                 = ""
    firstName             = ""
    lastName              = ""
    company               = ""
    website               = ""
  }

  deployment_mode = "Incremental"
}
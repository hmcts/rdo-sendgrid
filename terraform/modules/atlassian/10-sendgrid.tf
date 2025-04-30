resource "azurerm_resource_group_template_deployment" "sendgrid" {
  name                = var.sendgrid_deployment_tpl_name
  resource_group_name = var.resource_group_name
  template_content    = file("./modules/atlassian/sendgrid_saas_tpl.json")

  parameters_content = jsonencode({
    name = {
      value = var.sendgrid_account_name
    }
    planId = {
      value = var.sendgrid_plan_name
    }
    offerId = {
      value = var.sendgrid_offer_id
    }
    publisherId = {
      value = "sendgrid"
    }
    quantity = {
      value = 1
    }
    termId = {
      value = var.sendgrid_saas_term_id
    }
    azureSubscriptionId = {
      value = var.subscription_id
    }
    publisherTestEnvironment = {
      value = ""
    }
    autoRenew = {
      value = true
    }
    location = {
      value = "global"
    }
    tags = {
      value = var.tags
    }
  })

  deployment_mode = "Incremental"
  tags = var.tags
}
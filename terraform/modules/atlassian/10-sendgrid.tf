resource "azurerm_resource_group_template_deployment" "sendgrid" {
  name                = var.sendgrid_deployment_tpl_name
  resource_group_name = var.resource_group_name
  template_content    = file("./templates/sendgrid_saas.json")

  parameters_content = jsonencode({
    name = {
      value = var.sendgrid_account_name
    }
    planId = {
      value = var.sendgrid_plan_name
    }
    termId = {
      value = var.sendgrid_saas_term_id
    }
    azureSubscriptionId = {
      value = var.subscription_id
    }
    autoRenew = {
      value = true
    }
    storeFront = {
      value = "AzurePortal"
    }
    tags = {
      value = { for k, v in var.tags : k => v if k != "startupMode" }
    }
  })

  deployment_mode = "Incremental"
  tags = var.tags
}
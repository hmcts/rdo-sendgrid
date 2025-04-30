# Resource 'azurerm_template_deployment' has been replaced by 'azurerm_resource_group_template_deployment'
# in latest azurerm provider versions and is no longer recognised.
# To avoid delete/recreate cycle for existing sendgrid resources, import needs to be run into the new resource type
import {
  for_each = var.cft_subaccount_configs
  to       = module.cft-sendgrid[0].azurerm_resource_group_template_deployment.sendgrid[each.key]
  id       = "/subscriptions/${var.subscription_id}/resourceGroups/SendGrid-${var.env}/providers/Microsoft.Resources/deployments/${each.key}-sendgrid"
}

module "cft-sendgrid" {
  count  = var.env == "atlassian" ? 0 : 1
  source = "./modules/cft"

  env                   = var.env
  configs               = var.cft_subaccount_configs
  keyvault_policies     = var.cft_keyvault_policies
  subscription_id       = var.subscription_id
  sendgrid_saas_term_id = var.sendgrid_saas_term_id

  tags = module.ctags.common_tags
}

# Import existing SendGrid deployment template
import {
  for_each = var.env == "atlassian" ? [1] : []
  to       = module.atlassian-sendgrid[0].azurerm_resource_group_template_deployment.sendgrid
  id       = var.atlassian_sendgrid_config.existing_sendgrid_deployment_tpl_id
}

module "atlassian-sendgrid" {
  count  = var.env == "atlassian" ? 1 : 0
  source = "./modules/atlassian"

  providers = {
    azurerm = azurerm.atlassian_sendgrid
  }
  sendgrid_deployment_tpl_name = var.atlassian_sendgrid_config.sendgrid_deployment_tpl_name
  resource_group_name          = var.atlassian_sendgrid_config.resource_group_name
  subscription_id              = var.subscription_id
  sendgrid_account_name        = var.atlassian_sendgrid_config.sendgrid_account_name
  sendgrid_plan_name           = var.atlassian_sendgrid_config.sendgrid_plan_name
  sendgrid_saas_term_id        = var.sendgrid_saas_term_id

  tags = module.ctags.common_tags
}
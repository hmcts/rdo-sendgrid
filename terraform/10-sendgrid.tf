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
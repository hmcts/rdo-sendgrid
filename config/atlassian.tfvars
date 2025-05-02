env             = "atlassian"
subscription_id = "79898897-729c-41a0-a5ca-53c764839d95" # MOJ DCD Atlassian LVE
product         = "atlassian"
businessArea    = "Cross-Cutting"

atlassian_sendgrid_config = {
  existing_sendgrid_deployment_tpl_id = "/subscriptions/79898897-729c-41a0-a5ca-53c764839d95/resourceGroups/atlassian-prod-rg/providers/Microsoft.Resources/deployments/MarketplaceSaaS_62b3dd1c-cb30-4009-8373-ccdeac71728a"
  sendgrid_deployment_tpl_name        = "MarketplaceSaaS_62b3dd1c-cb30-4009-8373-ccdeac71728a"
  resource_group_name                 = "atlassian-prod-rg"
  sendgrid_account_name               = "SGAAPPATL01"
  sendgrid_plan_name                  = "pro-300k"
}


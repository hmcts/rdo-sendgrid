# Azure SendGrid

This repository provisions SendGrids accounts through the [Azure marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/sendgrid.sendgrid).

## Setting up a new account

Each team get's a non-production and a production account.

You can create new accounts by updating the configuration in 
[nonprod.tfvars](config/nonprod.tfvars) and [prod.tfvars](config/prod.tfvars)

### Choosing a tier

Tiers information is available on the [Azure marketplace](https://azuremarketplace.microsoft.com/en/marketplace/apps/SendGrid.SendGrid?tab=PlansAndPrice).

We recommend:
* by default use the free tier
* review your expected monthly volume and pick a higher tier if required
* if you are having issues with mail delivery due to spam list then pick the silver tier, (it's happened once that we are aware of).

### Choose a from address

You need to select a domain for your from address in non-production and production.

The standard pattern is:

* mail-your-product-nonprod.platform.hmcts.net
* mail-your-product.platform.hmcts.net

You may also serve your production domain from `service.gov.uk` if you have one.

e.g.

* mail.your-service.service.gov.uk 

## Setting up DMARC

[DMARC](https://en.wikipedia.org/wiki/DMARC) is required to authenticate that we own the domain that is being sent from.

It is setup using the 'Domain Authentication' feature in the SendGrid portal.

*The next steps require 'Contributor' access to the Azure resource*

To get to the SendGrid portal go to the account resource in Azure, i.e. sscs-nonprod and click 'Sender Identity', this will automatically log you in to the SendGrid portal.

_note: this doesn't always work, you might get invalid hash errors or if you were previously logged into another account it might not change the one you are logged in to. You can try again or if all else fails you can get the admin username ([stackoverflow instructions](https://stackoverflow.com/a/59957055/4951015)) and retrieve the password from vault._

1. Click 'Authenticate your domain'
2. Select 'Other Host (Not listed)
3. Type 'Azure'
4. brand links: normally we choose no (the default)
5. click 'Next'
6. enter the from domain, e.g. mail-sscs-nonprod.platform.hmcts.net
7. click 'Next'

You will now be on page that gives you DNS records that need to be added to the public DNS zone.

See an example pull request that was used to configure [SSCS's DMARC](https://github.com/hmcts/azure-public-dns/pull/360).

Once the DNS pull request has been merged, wait till it's applied.

Then tick 'I've added these records.' and click 'Verify'.

If successful then DMARC is all setup.

## API key

SendGrid requires an API key for sending emails through it.

You set one up via the SendGrid portal.

Once you're in the SendGrid portal (instructions in DMARC setup),

Click:

1. Settings
2. API Keys
3. Create API Key
4. name it: 'application'
5. Restricted Access
6. enable 'Mail Send'
7. Click create

Save this API key into the send grid vault

```bash
TEAM= # the team
ENVIRONMENT=nonprod # nonprod or prod
API_KEY= # the key from the send grid portal
az keyvault secret set --vault-name sendgrid${ENVIRONMENT} --name team-api-key --value "${API_KEY}"
```

repeat for production.

### Getting the key from the application

The API key should be read and stored into the application / team Key Vault via terraform.

See example [SSCS pull request](https://github.com/hmcts/sscs-evidence-share/pull/710),
note a mistake was made initially and the password was used instead of the API key, corrected in [PR#713](https://github.com/hmcts/sscs-evidence-share/pull/713).

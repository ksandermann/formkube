# Configuring Azure Login Credentials

## Creating an Azure Service Principal

FormKube is using Terraform to communicate to Azure, following the pattern of using an Azure Service Principal with a 
Client Secret. For more information on how to create such a Service Principal, see
[here](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html)

If you don't have the Azure CLI installed on your machine, you can use the following command to start an interactive 
Docker container containing Azure CLI:

```bash
docker run -it --rm ksandermann/cloud-toolbox:latest bash
```

## AKS Provider-Specific Tasks

### Granting permissions for Formkube Service Principle

The Service Principle needs to have the following permissions to permissions:

```json
{
  [...],
  "requiredResourceAccess": [
    {
      "resourceAppId": "00000002-0000-0000-c000-000000000000",
      "resourceAccess": [
        {
          "id": "311a71cc-e848-46a1-bdf8-97ff7156d8e6",
          "type": "Scope"
        },
        {
          "id": "1cda74f2-2616-4834-b122-5cb1b07f8a59",
          "type": "Role"
        }
      ]
    }
  ],
  [...]
}
```

They can be set via Web UI:

1. Navigate to `Azure Active Directory` -> `App registrations`
2. Select your Service Principal
3. Navigate to `API Permissions`
4. Add a permission
   1. Select unter the heading `Supported legacy APIs` `Azure Active Directory Graph`
   2. Select `Application permissions`
   3. Grant the permission `Application.ReadWrite.All`
5. Add a permission
   1. Select unter the heading `Supported legacy APIs` `Azure Active Directory Graph`
   2. Select `Delegated permissions`
   3. Grant the permission `User.Read`
6. Click on the button `Grant admin consent for directory`

Or via Azure CLI: (set the environment variable `FORMKUBE_CLIENT_ID`)

```sh
az ad app permission add \
    --id $FORMKUBE_CLIENT_ID \
    --api 00000002-0000-0000-c000-000000000000 \
    --api-permissions 311a71cc-e848-46a1-bdf8-97ff7156d8e6=Scope 1cda74f2-2616-4834-b122-5cb1b07f8a59=Role
az ad app permission grant --id $FORMKUBE_CLIENT_ID --api 00000002-0000-0000-c000-000000000000
az ad app permission admin-consent --id  $FORMKUBE_CLIENT_ID
```

## Manual Credential Configuration

When starting FormKube, you will therefore be prompted to enter the following credentials:

* *FORMKUBE_SUBSCRIPTION_ID*
The ID of the Azure subscription that should be used for the bootstrapped infrastructure.

* *FORMKUBE_CLIENT_ID*
The Service Principal's Client ID which should be used.

* *FORMKUBE_CLIENT_SECRET*
The Service Principal's Client Secret which should be used.

* *FORMKUBE_TENANT_ID*
The Service Principal's Tenant ID which should be used.

# Automatic Credential Configuration

In automation (i.e. CI/CD pipelines), it is also possible to set these values via the following environment variables:

* FORMKUBE_SUBSCRIPTION_ID
* FORMKUBE_CLIENT_ID
* FORMKUBE_CLIENT_SECRET
* FORMKUBE_TENANT_ID

If all of these environment variables are set, FormKube will not prompt to confirm your configuration before the
infrastructure is bootstrapped.

This is an exemplary bash script that sets the environment variables accordingly: 

```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Setting environment variables for FormKube"
export FORMKUBE_SUBSCRIPTION_ID=abcde-abcde-abcde-abcde
export FORMKUBE_CLIENT_ID=abcde-abcde-abcde-abcde
export FORMKUBE_CLIENT_SECRET=abcde-abcde-abcde-abcde
export FORMKUBE_TENANT_ID=abcde-abcde-abcde-abcde
```


# Authors
1. [ksandermann](https://github.com/ksandermann)
2. [sbibow](https://github.com/sbibow)
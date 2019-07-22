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
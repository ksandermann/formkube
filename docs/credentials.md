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

### Automatic creation of the Azure AD applications and service principles

When using the default installation, you will be asked to interactively login to Azure. You will need to login with a user that has the "Global admistrator" role.

The script will automatically create all needed service principles and applications for Azure Active Directory to integrate with Azure Kubernetes Service and pass the values to terraform.

### Manual creation of Azure AD applicaitons and service principles

You could also create the necessary applications and service princliples yourself. If you do so, you need to provide the environment variables `FORMKUBE_AAD_CLIENT_APPLICATION_ID`, `FORMKUBE_AAD_SERVER_APPLICATION_ID` and `FORMKUBE_AAD_SERVER_APPLICATION_SECRET`.

A tutorial on how to create the applications and service principles can be found in the [official Microsoft documentation on Integrate Azure Active Directory with Azure Kubernetes Service](https://docs.microsoft.com/en-gb/azure/aks/azure-ad-integration-cli).
You must not execute anything beyond the section "Create Azure AD client component". After granting the privileges for the client application you can retrieve the values of the variables like this:

```sh
export FORMKUBE_AAD_CLIENT_APPLICATION_ID=$clientApplicationId
export FORMKUBE_AAD_SERVER_APPLICATION_ID=$serverApplicationId
export FORMKUBE_AAD_SERVER_APPLICATION_SECRET=$serverApplicationSecret
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
export FORMKUBE_TENANT_ID=abcde-abcde-abcde-abcdeexport 
export FORMKUBE_AAD_SERVER_APPLICATION_SECRET=abcde-abcde-abcde-abcdeexport 
export FORMKUBE_AAD_SERVER_APPLICATION_ID=abcde-abcde-abcde-abcdeexport 
export FORMKUBE_AAD_CLIENT_APPLICATION_ID=abcde-abcde-abcde-abcdeexport 
```


# Authors
1. [ksandermann](https://github.com/ksandermann)
2. [sbibow](https://github.com/sbibow)
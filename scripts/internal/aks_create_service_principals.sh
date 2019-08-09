#!/bin/bash
set -uo pipefail
IFS=$'\n\t'


#https://docs.microsoft.com/en-us/azure/aks/azure-ad-integration-cli


echo "Please login with an Azure AD Global Administrator user."

az login -o none

if [ -z ${FORMKUBE_AAD_SERVER_APPLICATION_SECRET+x} ]; then
    read -p "Enter Azure AD Server Application Secret: " fk_int_aad_server_app_secret
else
    fk_int_aad_server_app_secret=FORMKUBE_AAD_SERVER_APPLICATION_SECRET
    echo "Picked up Azure AD Server Application Secretfrom environment variable FORMKUBE_AAD_SERVER_APPLICATION_SECRET!"
fi

export FORMKUBE_AAD_SERVER_APPLICATION_SECRET=${fk_int_aad_server_app_secret}

echo "Creating Azure AD Server Application..."
serverApplicationId=$(az ad app create \
    --display-name "${FORMKUBE_CLUSTER}Server" \
    --identifier-uris "https://${FORMKUBE_CLUSTER}Server" \
    --query appId -o tsv)
echo "Success!"

echo "Sleeping 30 sec to ensure Azure AD propagation..."
sleep 30
echo "Creating a service principal for the Azure AD server application if it doesnt exist..."
#cannot be forwarded to /dev/null
az ad sp show --id $serverApplicationId || az ad sp create --id $serverApplicationId
echo "Success!"

echo "Setting the server service principal secret..."
az ad sp credential reset \
    --name $serverApplicationId \
    --credential-description "AKS-AAD-PW" \
    --password ${FORMKUBE_AAD_SERVER_APPLICATION_SECRET} \
    --years 10 \
    -o none
echo "Success!"

echo "Adding delegated permissions User.Read and Directory.Read.All as well as application permission Directory.Read.All to the service principal..."
az ad app permission add \
    --id $serverApplicationId \
    --api 00000003-0000-0000-c000-000000000000 \
    --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope 06da0dbc-49e2-44d2-8312-53f166ab848a=Scope 7ab1d382-f21e-4acd-a863-ba3e13f7da61=Role >/dev/null
echo "Success!"

echo "Granting added permissions on Microsoft Graph API..."
az ad app permission grant --id $serverApplicationId --api 00000003-0000-0000-c000-000000000000 -o none
echo "Success!"

echo "Sleeping 30 sec to ensure Azure AD propagation..."
sleep 30
echo "Giving admin-consent to added permissions...."
az ad app permission admin-consent --id  $serverApplicationId -o none
echo "Success!"

echo "Creating Azure AD Client Application..."
clientApplicationId=$(az ad app create \
    --display-name "${FORMKUBE_CLUSTER}Client" \
    --native-app \
    --reply-urls "https://${FORMKUBE_CLUSTER}Client" \
    --query appId -o tsv)
echo "Success!"

echo "Sleeping 30 sec to ensure Azure AD propagation..."
sleep 30
echo "Creating a service principal for the Azure AD server application if it doesnt exist..."
#cannot be forwarded to /dev/null
az ad sp show --id $clientApplicationId || az ad sp create --id $clientApplicationId  -o none
echo "Success!"

echo "Adding OAuth permissions for the server application to the client service principal...."
oAuthPermissionId=$(az ad app show --id $serverApplicationId --query "oauth2Permissions[0].id" -o tsv)
az ad app permission add --id $clientApplicationId --api $serverApplicationId --api-permissions $oAuthPermissionId=Scope -o none
echo "Success!"

echo "Sleeping 30 sec to ensure Azure AD propagation..."
sleep 30
echo "Giving admin-consent to added permissions...."
az ad app permission grant --id $clientApplicationId --api $serverApplicationId -o none
echo "Success!"


export FORMKUBE_AAD_SERVER_APPLICATION_ID=$serverApplicationId
export FORMKUBE_AAD_CLIENT_APPLICATION_ID=$clientApplicationId

az logout
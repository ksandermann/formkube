#!/bin/bash
set -euo pipefail
IFS=$'\n\t'



#shoutout to https://stackoverflow.com/a/13864829
#check if running in automation and all vars have been set through envs
if [ -z ${FORMKUBE_SUBSCRIPTION_ID+x} ] || [ -z ${FORMKUBE_CLIENT_ID+x} ] || [ -z ${FORMKUBE_CLIENT_SECRET+x} ] || [ -z ${FORMKUBE_TENANT_ID+x} ]; then
    fk_int_automation=false
else
    fk_int_automation=true
fi


#getting all vars from envs
if [ -z ${FORMKUBE_SUBSCRIPTION_ID+x} ]; then
    read -p "Enter Azure subscription id: " fk_int_sub_id
else
    fk_int_sub_id=$FORMKUBE_SUBSCRIPTION_ID
    echo "Picked up Azure subscription id $FORMKUBE_SUBSCRIPTION_ID from environment variable FORMKUBE_SUBSCRIPTION_ID!"
fi

if [ -z ${FORMKUBE_CLIENT_ID+x} ]; then
    read -p "Enter Azure client id: " fk_int_client_id
else
    fk_int_client_id=$FORMKUBE_CLIENT_ID
    echo "Picked up Azure client id $FORMKUBE_CLIENT_ID from environment variable FORMKUBE_CLIENT_ID!"
fi

if [ -z ${FORMKUBE_CLIENT_SECRET+x} ]; then
    read -p "Enter Azure client secret: " fk_int_client_secret
else
    fk_int_client_secret=$FORMKUBE_CLIENT_SECRET
    echo "Picked up Azure client secret $FORMKUBE_CLIENT_SECRET from environment variable FORMKUBE_CLIENT_SECRET!"
fi

if [ -z ${FORMKUBE_TENANT_ID+x} ]; then
    read -p "Enter Azure tenant id: " fk_int_tenant_id
else
    fk_int_tenant_id=$FORMKUBE_TENANT_ID
    echo "Picked up Azure tenant id $FORMKUBE_TENANT_ID from environment variable FORMKUBE_TENANT_ID!"
fi

if [ "$fk_int_automation" = true ]; then
    echo "FormKube running in automation mode - Picked up all credentials from envs!"
else
    echo "The following configuration will be used to communicate with Azure:"
    echo "Azure subscription id: $fk_int_sub_id"
    echo "Azure client id: $fk_int_client_id"
    echo "Azure client secret: $fk_int_client_secret"
    echo "Azure tenant id: $fk_int_tenant_id"
    read -p "Continue? (Y/N): " confirm && [[ ${confirm} == [yY] || ${confirm} == [yY][eE][sS] ]] || exit 1
fi


export ARM_SUBSCRIPTION_ID=${fk_int_sub_id}
export ARM_CLIENT_ID=${fk_int_client_id}
export ARM_CLIENT_SECRET=${fk_int_client_secret}
export ARM_TENANT_ID=${fk_int_tenant_id}


echo "Logging in to Azure..."
az login --service-principal --username "${ARM_CLIENT_ID}" --password "${ARM_CLIENT_SECRET}" --tenant "${ARM_TENANT_ID}"

echo "Setting azure subscription to $ARM_SUBSCRIPTION_ID"
az account set --subscription="${ARM_SUBSCRIPTION_ID}"

echo "Successfully logged into Azure!"

####################################################Configuration#######################################################

if [ -z ${FORMKUBE_LOGLEVEL+x} ]; then
    export FORMKUBE_LOGLEVEL="INFO"
fi

echo "Setting loglevel to $FORMKUBE_LOGLEVEL..."
export TF_LOG="$FORMKUBE_LOGLEVEL"
export TF_LOG_PATH="/root/project/clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.log"

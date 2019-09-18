#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


if [ "$FORMKUBE_PROVIDER" == "aks" ] && [ -z ${FORMKUBE_AAD_SERVER_APPLICATION_ID+x} ] && [ -z ${FORMKUBE_AAD_CLIENT_APPLICATION_ID+x} ] ; then
    echo "Not all environment variables FORMKUBE_AAD_SERVER_APPLICATION_SECRET, FORMKUBE_AAD_SERVER_APPLICATION_ID, FORMKUBE_AAD_CLIENT_APPLICATION_ID were set."
    source /root/project/scripts/internal/aks_create_service_principals.sh
fi


source /root/project/scripts/internal/az_login.sh


terraform init -input=false providers/$FORMKUBE_PROVIDER


#TODO only pass aks_ vars of provider=aks

source /root/project/scripts/internal/plan.sh



terraform apply -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.plan


if [ "$FORMKUBE_PROVIDER" == "aks" ]; then

terraform output -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate admin_kube_config
terraform output -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate user_kube_config

fi


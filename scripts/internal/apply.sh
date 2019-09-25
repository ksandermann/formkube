#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


if [ "$FORMKUBE_PROVIDER" == "aks" ] && [ -z ${FORMKUBE_AAD_SERVER_APPLICATION_ID+x} ] && [ -z ${FORMKUBE_AAD_CLIENT_APPLICATION_ID+x} ] ; then
    echo "Not all environment variables FORMKUBE_AAD_SERVER_APPLICATION_SECRET, FORMKUBE_AAD_SERVER_APPLICATION_ID, FORMKUBE_AAD_CLIENT_APPLICATION_ID were set."
    source /root/project/scripts/internal/aks_create_service_principals.sh
fi


source /root/project/scripts/internal/az_login.sh


source /root/project/scripts/internal/init.sh


source /root/project/scripts/internal/plan.sh


terraform apply /root/project/clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.plan


if [ "$FORMKUBE_PROVIDER" == "aks" ]; then

terraform output user_kube_config
terraform output admin_kube_config

fi

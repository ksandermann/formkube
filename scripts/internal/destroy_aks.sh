#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


#development mode, disable backup
if [ "$FORMKUBE_DEVELOPMENT_MODE" == "true" ]; then
    echo -e "\e[1m\e[41m\e[97m\n"
    echo -e "Caution: FormKube is running in development mode. Destroying EVERYTHING."
    echo -e "\e[39m\e[0m\e[49m\n"
    terraform destroy \
    -var aks_cluster_k8s_serviceaccount_client_id=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID \
    -var aks_cluster_k8s_serviceaccount_client_secret=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET \
    -var aks_cluster_k8s_ad_server_app_secret=$FORMKUBE_AAD_SERVER_APPLICATION_SECRET \
    -var aks_cluster_k8s_ad_client_app_id=$FORMKUBE_AAD_CLIENT_APPLICATION_ID \
    -var aks_cluster_k8s_ad_server_app_id=$FORMKUBE_AAD_SERVER_APPLICATION_ID \
    -var aks_cluster_k8s_ad_tenant_id=$FORMKUBE_TENANT_ID \
    -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
    -auto-approve
else

    terraform destroy \
    -var aks_cluster_k8s_serviceaccount_client_id=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID \
    -var aks_cluster_k8s_serviceaccount_client_secret=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET \
    -var aks_cluster_k8s_ad_server_app_secret=$FORMKUBE_AAD_SERVER_APPLICATION_SECRET \
    -var aks_cluster_k8s_ad_client_app_id=$FORMKUBE_AAD_CLIENT_APPLICATION_ID \
    -var aks_cluster_k8s_ad_server_app_id=$FORMKUBE_AAD_SERVER_APPLICATION_ID \
    -var aks_cluster_k8s_ad_tenant_id=$FORMKUBE_TENANT_ID \
    -var-file=/root/project/clusters/$FORMKUBE_CLUSTER/vars.tfvars
fi

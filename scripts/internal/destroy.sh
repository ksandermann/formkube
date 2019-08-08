#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source /root/project/scripts/internal/az_login.sh

terraform init providers/$FORMKUBE_PROVIDER

export FORMKUBE_MASTER_DISKS_DELETED=$(terraform output -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate -json out_masters_os_disk_delete_on_destroy)

#development mode, disable backup
if [ "$FORMKUBE_DEVELOPMENT_MODE" == "true" ]; then
    echo -e "\e[1m\e[41m\e[97m\n"
    echo -e "Caution: FormKube is running in development mode. Destroying EVERYTHING."
    echo -e "\e[39m\e[0m\e[49m\n"
    terraform destroy \
    -var aks_cluster_k8s_serviceaccount_client_id=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID \
    -var aks_cluster_k8s_serviceaccount_client_secret=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET \
    -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
    -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate \
    -auto-approve \
    providers/$FORMKUBE_PROVIDER
else
    echo "removing backup vault from statefile..."
    terraform state rm -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate module.backup.azurerm_recovery_services_vault.platform  &>/dev/null

    echo "removing dns zone from statefile..."
    terraform state rm -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate module.essentials.azurerm_dns_zone.platform  &>/dev/null

    echo "removing resource group from statefile..."
    terraform state rm -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate module.essentials.azurerm_resource_group.platform  &>/dev/null

    terraform destroy \
    -var aks_cluster_k8s_serviceaccount_client_id=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID \
    -var aks_cluster_k8s_serviceaccount_client_secret=$FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET \
    -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
    -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate \
    providers/$FORMKUBE_PROVIDER

    echo -e "\e[1m\e[41m\e[97m\n"
    echo -e "Caution: Did not destroy resource group to prevent destroying infrastructure managed by other providers.\n"
    echo -e "Caution: Did not destroy backup vault to keep backups in case of accidentally deletion.\n"
    echo -e "Caution: Did not destroy DNS zone to keep Azure nameservers in case of external registrar usage.\n"

    if [ "$FORMKUBE_MASTER_DISKS_DELETED" == "false" ]; then
       echo -e "Caution: Did not destroy disks of masters to prevent accidental data loss.\n"
    fi

    #https://misc.flogisoft.com/bash/tip_colors_and_formatting
    echo -e "\e[39m\e[0m\e[49m\n"
fi

echo -e "Destruction complete!"
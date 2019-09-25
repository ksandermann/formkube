#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source /root/project/scripts/internal/az_login.sh

source /root/project/scripts/internal/init.sh

export FORMKUBE_MASTER_DISKS_DELETED=$(terraform output -json out_masters_os_disk_delete_on_destroy)

if [ "$FORMKUBE_PROVIDER" == "aks" ]; then

source /root/project/scripts/internal/destroy_aks.sh

fi

if [ "$FORMKUBE_PROVIDER" == "azure" ]; then

source /root/project/scripts/internal/destroy_azure.sh

fi

echo -e "Destruction complete!"

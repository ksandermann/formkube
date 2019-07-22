#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


source /root/project/scripts/internal/az_login.sh


terraform init -input=false providers/$FORMKUBE_PROVIDER

#development mode, disable backup
if [ "$FORMKUBE_DEVELOPMENT_MODE" == "true" ]; then
    echo -e "\e[1m\e[41m\e[97m\n"
    echo -e "Caution: FormKube is running in development mode. Disabling backup."
    echo -e "\e[39m\e[0m\e[49m\n"
    terraform plan \
    -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
    -out clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.plan \
    -var masters_os_disk_delete_on_destroy=true \
    -var masters_backup_enabled=false \
    -var computenodes_backup_enabled=false \
    -var infranodes_backup_enabled=false \
    -var bastions_backup_enabled=false \
    -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate \
    providers/$FORMKUBE_PROVIDER
else
    terraform plan \
    -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
    -out clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.plan \
    -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate \
    providers/$FORMKUBE_PROVIDER
fi

terraform apply  -state=clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.tfstate clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.plan



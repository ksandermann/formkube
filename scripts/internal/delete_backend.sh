#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source /root/project/scripts/internal/az_login.sh

cd /root/project/providers/azure_backend

terraform init \
  -input=false

terraform state rm \
  -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate \
  module.azure_backend.azurerm_resource_group.backend

terraform destroy \
  -var-file=/root/project/clusters/$FORMKUBE_CLUSTER/vars.tfvars \
  -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate

rm -rf /root/project/clusters/$FORMKUBE_CLUSTER/backend.plan || true

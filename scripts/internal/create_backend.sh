#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source /root/project/scripts/internal/az_login.sh

cd /root/project/providers/azure_backend

terraform init \
  -input=false

terraform plan \
  -out /root/project/clusters/$FORMKUBE_CLUSTER/backend.plan \
  -var-file=/root/project/clusters/$FORMKUBE_CLUSTER/vars.tfvars

terraform apply \
  -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate \
  /root/project/clusters/$FORMKUBE_CLUSTER/backend.plan

export FORMKUBE_BACKEND_RG_NAME=$(terraform output -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate out_rg_name)

export FORMKUBE_BACKEND_SA_NAME=$(terraform output -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate out_sa_name)

export FORMKUBE_BACKEND_SC_NAME=$(terraform output -state=/root/project/clusters/$FORMKUBE_CLUSTER/backend.tfstate out_sc_name)


echo resource_group_name = \"$FORMKUBE_BACKEND_RG_NAME\" > /root/project/clusters/$FORMKUBE_CLUSTER/backendconfig

echo storage_account_name = \"$FORMKUBE_BACKEND_SA_NAME\" >> /root/project/clusters/$FORMKUBE_CLUSTER/backendconfig

echo container_name = \"$FORMKUBE_BACKEND_SC_NAME\" >> /root/project/clusters/$FORMKUBE_CLUSTER/backendconfig

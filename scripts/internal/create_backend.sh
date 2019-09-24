#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source /root/project/scripts/internal/az_login.sh

terraform init \
  -input=false \
  providers/azure_backend

terraform plan \
  -out clusters/$FORMKUBE_CLUSTER/backend.plan \
  -var-file=clusters/$FORMKUBE_CLUSTER/vars.tfvars \
  providers/azure_backend/

terraform apply \
  -state=./clusters/$FORMKUBE_CLUSTER/backend.tfstate \
  clusters/$FORMKUBE_CLUSTER/backend.plan

export FORMKUBE_BACKEND_RG_NAME=$(terraform output -state=./clusters/$FORMKUBE_CLUSTER/backend.tfstate out_rg_name)

export FORMKUBE_BACKEND_SA_NAME=$(terraform output -state=./clusters/$FORMKUBE_CLUSTER/backend.tfstate out_sa_name)

export FORMKUBE_BACKEND_SC_NAME=$(terraform output -state=./clusters/$FORMKUBE_CLUSTER/backend.tfstate out_sc_name)


echo resource_group_name = \"$FORMKUBE_BACKEND_RG_NAME\" > clusters/$FORMKUBE_CLUSTER/backendconfig

echo storage_account_name = \"$FORMKUBE_BACKEND_SA_NAME\" >> clusters/$FORMKUBE_CLUSTER/backendconfig

echo container_name = \"$FORMKUBE_BACKEND_SC_NAME\" >> clusters/$FORMKUBE_CLUSTER/backendconfig

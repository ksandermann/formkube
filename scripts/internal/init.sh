#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#MANDATORY AF
#providing DIR to terraform init doesnt work
cd /root/project/providers/$FORMKUBE_PROVIDER

terraform init \
  -input=false \
  -backend-config=/root/project/clusters/$FORMKUBE_CLUSTER/backendconfig

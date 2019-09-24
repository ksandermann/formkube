#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

terraform init \
  -input=false \
  -backend-config=clusters/$FORMKUBE_CLUSTER/backendconfig \
  providers/$FORMKUBE_PROVIDER

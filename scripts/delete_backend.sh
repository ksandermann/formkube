#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ./scripts/internal/setup.sh

docker run -ti --rm \
    -v ~/.ssh:/root/.ssh \
    -v ${PWD}:/root/project \
    --env-file <(env | grep FORMKUBE_) \
    $FORMKUBE_BOOTSTRAP_ENVIRONMENT \
    bash /root/project/scripts/internal/delete_backend.sh

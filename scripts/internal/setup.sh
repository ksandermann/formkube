#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [ -z ${FORMKUBE_CLUSTER+x} ]; then
    echo "Environment variable FORMKUBE_CLUSTER is not set."
    read -p "Please enter the name of the folder inside 'clusters' where your configuration is stored: " fk_int_cluster
    export FORMKUBE_CLUSTER=$fk_int_cluster
fi


#https://github.com/ksandermann/cloud-toolbox
export FORMKUBE_BOOTSTRAP_ENVIRONMENT="ksandermann/cloud-toolbox:2019-07-18_01"

#only azure supported for now
export FORMKUBE_PROVIDER="azure"

echo "Downloading latest version of FormKube runtime -  '$FORMKUBE_BOOTSTRAP_ENVIRONMENT'..."
docker pull $FORMKUBE_BOOTSTRAP_ENVIRONMENT  &>/dev/null

if [ -z ${FORMKUBE_DEVELOPMENT_MODE+x} ]; then
    export FORMKUBE_DEVELOPMENT_MODE=false
fi

if [[ "$FORMKUBE_DEVELOPMENT_MODE" != "true"]] && [["$FORMKUBE_DEVELOPMENT_MODE" != "false" ]];then
    export FORMKUBE_DEVELOPMENT_MODE=false
fi
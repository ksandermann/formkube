#!/bin/bash
set -uo pipefail
IFS=$'\n\t'

if [ -z ${FORMKUBE_CLUSTER+x} ]; then
    echo "Environment variable FORMKUBE_CLUSTER is not set."
    read -p "Please enter the name of the folder inside 'clusters' where your configuration is stored: " fk_int_cluster
    export FORMKUBE_CLUSTER=$fk_int_cluster
fi

if [ -z ${FORMKUBE_PROVIDER+x} ]; then
    echo "Environment variable FORMKUBE_PROVIDER is not set."
    read -p "Please enter the provider you want to use (aks and azure currently supported): " fk_int_provider
    export FORMKUBE_PROVIDER=$fk_int_provider
fi

#https://github.com/ksandermann/cloud-toolbox
export FORMKUBE_BOOTSTRAP_ENVIRONMENT="ksandermann/cloud-toolbox:2019-08-08_01"

echo "Downloading latest version of FormKube runtime -  '$FORMKUBE_BOOTSTRAP_ENVIRONMENT'..."
docker pull $FORMKUBE_BOOTSTRAP_ENVIRONMENT  &>/dev/null

if [ -z ${FORMKUBE_DEVELOPMENT_MODE+x} ]; then
    export FORMKUBE_DEVELOPMENT_MODE=false
fi

if [[ "$FORMKUBE_DEVELOPMENT_MODE" != "true"]] && [["$FORMKUBE_DEVELOPMENT_MODE" != "false" ]];then
    export FORMKUBE_DEVELOPMENT_MODE=false
fi
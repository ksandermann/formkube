# FormKube - Bootstrap the Infrastructure for Vanilla Kubernetes/OpenShift or deploy a fully managed AKS Kubernetes Cluster on Azure

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

FormKube allows you to bootstrap all the needed infrastructure components to deploy Kubernetes or OpenShift clusters
on Azure. Additionally, FormKube allows you to bootstrap a fully managed and integrated AKS Cluster.

It's basically the infrastructure part of tectonic-installer for Azure, extended by various features such as multi-zone 
high-availability, scheduled backup and others.
Click [here](docs/tectonic_comparison.md) for a full comparison.

FormKube is based on [Terraform](https://www.terraform.io/) and [Docker](https://docs.docker.com/).
It is basically the result of me teaching myself Terraform and Azure. :)

## Prerequisites to Bootstrap a Platform
1. [Azure Credential Configuration](docs/credentials.md)
1. [Bootstrapping Prerequisites](docs/prerequisites.md)


## Installation Guide
1. [Bootstrapping a Platform](docs/install_guide.md)
1. [Post Installation Guide](docs/post_install_guide.md)
1. [Destroying a Platform](docs/destroy_guide.md)


## Architecture Documentation
1. [Network Architecture](docs/network_architecture.md)
1. [Network Security Architecture](docs/network_security.md)
1. [DNS Configuration](docs/dns.md)
1. [Understanding FormKube's Naming Conventions](docs/conventions.md)


## Developer Documentation

1. [Development Mode](docs/dev_mode.md)
1. [ToDos](docs/todo.md)
1. [Version History](docs/versioning.md)
1. [Considered Features for future releases](docs/roadmap.md)


## TL;DR

1. Ensure Docker and Bash is installed and you are using a filesystem able to mount files into Ubuntu-based docker containers.

1. Adjust sample inventory.

1. For the Azure provider, un the following in the repo's root dir:
    ```bash
    export FORMKUBE_PROVIDER=azure
    export FORMKUBE_CLUSTER=mycluster.mydomain.com #has to be the name of the folder with your configuration inside the clusters dir
    export FORMKUBE_SUBSCRIPTION_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_CLIENT_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_CLIENT_SECRET=abcde-abcde-abcde-abcde
    export FORMKUBE_TENANT_ID=abcde-abcde-abcde-abcde
    bash ./scripts/apply.sh
    ```

1. For the AKS provider, un the following in the repo's root dir:
    ```bash
    export FORMKUBE_PROVIDER=aks
    export FORMKUBE_CLUSTER=mycluster.mydomain.com #has to be the name of the folder with your configuration inside the clusters dir
    export FORMKUBE_SUBSCRIPTION_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_CLIENT_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_CLIENT_SECRET=abcde-abcde-abcde-abcde
    export FORMKUBE_TENANT_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET=abcde-abcde-abcde-abcde
    export FORMKUBE_AAD_SERVER_APPLICATION_SECRET=CanBeChosenFreelyButNeverChanged
    bash ./scripts/apply.sh
    ```



# Authors
1. [ksandermann](https://github.com/ksandermann)

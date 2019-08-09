# Bootstrapping Prerequisites

## Bootstrapping Environment
As FormKube is built using a pre-packed docker image, there is not a lot you need ti install in order to run FormKube:

* [Docker](https://docs.docker.com/)

* bash

* a filesystem that support's mounting of local files into an Ubuntu-based docker container, like ext4, xfs or APFS 
(NTFS is not supported at this moment)

## Cluster Configuration

* For configuring a cluster, you can take a look at the sample configurations [here](../clusters).
Your configuration must be placed inside a folder inside the *clusters* folder and it is recommended to
name the folder like your cluster's FQDN, for example k8s-dev.example.com.
To configure FormKube to work with the cluster, you have to export the environment variable FORMKUBE_CLUSTER:
    ```bash
    export FORMKUBE_CLUSTER=k8s-dev.example.com
    ```

* FormKube currently supports bare bootstrapping of the infrastructure needed to deploy Kubernetes on your own, as well 
as deploying Kubernetes using Azure Kubernetes Service. To configure the provider you want to use (azure for infrastructure
only, aks for a full Kubernetes cluster), you need to export the following environment variable:
    ```bash
    # either 
    export FORMKUBE_PROVIDER=aks
    # or 
    export FORMKUBE_PROVIDER=azure
    ```
    The cluster configuration varies depending on the provider you are using. For example, when using the AKS provider,
    infranodes are not supported. Instead, there are a couple of AKS-specific variables that need to be defined. These
    variables are prefixed with *aks_*. 
    
* Additionally, when using the aks provider, you will need to specify additional environment variables for the service
principal that the Kubernetes Azure Cloud Provider will use. The following environment variables need to be exported:
    ```bash
    export FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_ID=abcde-abcde-abcde-abcde
    export FORMKUBE_AKS_SERVICE_PRINCIPAL_CLIENT_SECRET=abcde-abcde-abcde-abcde
    ```
* Also, when using the aks provider, you have to choose a password for the AAD Server Application. The password can be 
chosen freely, but must never be changed. 
    ```bash
    export FORMKUBE_AAD_SERVER_APPLICATION_SECRET=CanBeChosenFreelyButNeverChanged
    ```




* At this time, FormKube cannot generate ssh keys on its own so you have to provide pre-generated ssh keys who's public
keys will be placed on your vms on Azure. It is recommended to generate ssh keys as described
[here](https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
FormKube will have access to your controller's local path *~/.ssh/*, which can be referenced in the variables
*bastions_pub_key_controller_path*, *masters_pub_key_controller_path*, *computenodes_pub_key_controller_path* and 
*infranodes_pub_key_controller_path*.


# Authors
1. [ksandermann](https://github.com/ksandermann)
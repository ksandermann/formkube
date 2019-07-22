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

* As FormKube uses Azure availability zones, you need to take a look
[here](https://docs.microsoft.com/bs-latn-ba/azure/availability-zones/az-overview#services-support-by-region)
which regions are supported.

* At this time, FormKube cannot generate ssh keys on its own so you have to provide pre-generated ssh keys who's public
keys will be placed on your vms on Azure. It is recommended to generate ssh keys as described
[here](https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
FormKube will have access to your controller's local path *~/.ssh/*, which can be referenced in the variables
*bastions_pub_key_controller_path*, *masters_pub_key_controller_path*, *computenodes_pub_key_controller_path* and 
*infranodes_pub_key_controller_path*.


# Authors
1. [ksandermann](https://github.com/ksandermann)
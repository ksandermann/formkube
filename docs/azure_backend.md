# Creating the Terraform Remote State Azure Backend

-link zu generellen doku

## Creating the Backend

The creation of the Azure Remote State Backend can be done with FormKube:

```bash

bash ./scripts/create_backend.sh

```

The configuration of the Azure Storage Account and Azure Storage Container will be auto-generated using the vars defined
in the vars.tf of the cluster, such as the *cluster_name* and *cluster_domain*.
The resource group in which the state will be placed defaults to *FormKubeStates*.
It can also be explicitly defined/changed by setting *state_rg_name* in the cluster's vars.tf.

In the background, FormKube will generate a backendconfig inside clusters/$FORMKUBE_CLUSTER/backendconfig which will
then later be used when applying the cluster.


## Supplying an already existing Backend

It is also possible to use an existing Azure Storage Account and Azure Storage Container as remote backend.
To do so, simply put your configuration inside clusters/$FORMKUBE_CLUSTER/backendconfig and skip above step to create
the backend.

Exemplary backendconfig's can be found the the clusters folder inside this repo.

NOTE: FormKube authenticates itself with the backend using the Service Principal you provide it to run terraform.
Please ensure that the Service Principal has the correct permissions to access the Azure Storage Account and 
Azure Storage Container and that the Tenant ID and Subscription ID match.


# Authors
1. [ksandermann](https://github.com/ksandermann)


was passiert bei destroy mit den state stores
terraform init nochmal laufen lassen ? -> gibts uninitialihze?
destroy testen

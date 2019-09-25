# Creating the Terraform Remote State Azure Backend

FormKube uses the Terraform Azure Remote State Backend [azurerm](https://www.terraform.io/docs/backends/types/azurerm.html)
to store its state.

It is mandatory to work with the azurerm backend. Local statefiles are not supported anymore in FormKube >= 3.0.0.

For more information on Terraform Remote State Backends, please refer to the [official Docs](https://www.terraform.io/docs/state/remote.html).


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

Exemplary backendconfig's can be found in the *clusters* folder inside this repo.

NOTE: FormKube authenticates itself with the backend using the Service Principal you provide it to run terraform.
Please ensure that the Service Principal has the correct permissions to access the Azure Storage Account and 
Azure Storage Container and that the Tenant ID and Subscription ID match.

## Deleting the Backend

Deleting the backend Azure Storage Account and Azure Storage Container can be done with FormKube:

```bash

bash ./scripts/delete_backend.sh

```

Important: Running *./scripts/destroy.sh* does not include deleting the backend.

# Authors
1. [ksandermann](https://github.com/ksandermann)

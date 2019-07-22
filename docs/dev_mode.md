# Development Mode

## Enabling the Develoment Mode

When developing FormKube itself or you are just trying to quickly test various configurations, it is reasonable to 
enable FormKube's development mode. 
You can do this by exporting the following environment variable:
```bash
export FORMKUBE_DEVELOPMENT_MODE=true
```

Enabling development mode has the following consequences:

1. Backup will be disabled for all components
1. The backup vault will be deleted when running destroy
1. The resource group will be deleted when running destroy, even resources in the resource group that were not
provisioned by FormKube will be destroyed !
1. You will not be prompted for confirmation on destroy.

**NOTE**: When quickly applying and destroying various configurations, ensure that you always change the value of 
*backup_vault_name* before re-applying. For more information check out
[this issue](https://github.com/ksandermann/formkube/issues/3).

## Adjusting the loglevel

FormKube stores the Terraform logs inside *clusters/$FORMKUBE_CLUSTER/$FORMKUBE_CLUSTER.log*.

To adjust the loglevel, you can export the environment variable *FORMKUBE_LOGLEVEL* to the values documented
[here](https://www.terraform.io/docs/internals/debugging.html).


# Authors
1. [ksandermann](https://github.com/ksandermann)
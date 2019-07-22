# Destroying a Platform

1. Ensure you configured everything as described in the [Bootstrapping Prerequisites](./prerequisites.md)

1. Ensure you configured everything as described in [Configuring Azure Login Credentials](./credentials.md)

1. Run the following inside bash in the repository's root directory:

    ```bash
    ./scripts/destroy.sh
    ```

The following resources will **not** be destroyed when running FormKube's destroy:

1. Backup vault including backups
1. Resource Group defined in *platform_rg_name*
1. If *masters_os_disk_delete_on_destroy* is **not** explicitly to *true*, the OS disks of the masters will also not be
destroyed.

If you want to quickly test various configurations and don't want to manually delete these values after each apply,
check out [FormKube's Development Mode](dev_mode.md).

# Authors
1. [ksandermann](https://github.com/ksandermann)
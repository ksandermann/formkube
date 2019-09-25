# Bootstrapping a Platform

1. Clone this repository

1. Ensure you configured everything as described in the [Bootstrapping Prerequisites](./prerequisites.md)

1. Ensure you configured everything as described in [Configuring Azure Login Credentials](./credentials.md)

1. Ensure you created the terraform remote state azure backend as described in [Creating the Terraform Remote State Azure Backend](./azure_backend.md)

1. Run the following inside bash in the repository's root directory:
    ```bash
    ./scripts/apply.sh
    ```

# Authors
1. [ksandermann](https://github.com/ksandermann)

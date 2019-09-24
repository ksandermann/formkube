terraform {
  required_version = "0.12.8"
}

provider "azurerm" {
  version = "~> 1.33.1"
}

provider "random" {
  version = "~> 2.2"
}

module "essentials" {
  source = "../../modules/azure_backend"

  platform_location = var.platform_location
  platform_rg_name = var.platform_rg_name
}

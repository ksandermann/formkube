output "out_rg_name"{
  value = azurerm_resource_group.backend.name
}

output "out_sa_name"{
  value = azurerm_storage_account.backend.name
}

output "out_sc_name"{
  value = azurerm_storage_container.backend.name
}


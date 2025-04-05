output "app_service_name" {
  value = azurerm_app_service.app.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

provider "azurerm" {
    features {}
    subscription_id = "c8ff8dd0-448a-49f6-a740-1911bf8396a8"
}

resource "azurerm_resource_group" "rg" {
  name     = "my-jenkins-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "my-jenkins-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "myjenkinsappsvc123"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

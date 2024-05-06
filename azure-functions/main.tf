terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.102.0"
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "${var.azurerm_resource_group_name}"
  location = "${var.azurerm_resource_group_location}"
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.azurerm_storage_account_name}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "${var.azurerm_storage_account_tier}"
  account_replication_type = "${var.azurerm_storage_account_replication_type}"

}

resource "azurerm_service_plan" "example" {
  name                = "${var.azurerm_service_plan_name}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "${var.azurerm_service_plan_os_type}"
  sku_name            = "${var.azurerm_service_plan_sku_name}"
}


resource "azurerm_linux_function_app" "example" {
  name                = "${var.azurerm_linux_function_app_name}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_function_app_function" "example" {
  name            = "${var.azurerm_function_app_function_name}"
  function_app_id = azurerm_linux_function_app.example.id
  language        = "${var.azurerm_function_app_function_language}"
  test_data = jsonencode({
    "name" = "${var.test_data_name}"
  })
  config_json = jsonencode({
    "bindings" = "${var.test_data_bindings}"
  })
}
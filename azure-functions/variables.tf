variable "azurerm_resource_group_name" {
  type = string
  default = "example"
}

variable "azurerm_resource_group_location" {
  type = string
  default = "West Europe"
}

variable "azurerm_storage_account_name" {
  type = string
  default = "storageaccountname"
}

variable "azurerm_storage_account_tier" {
  type = string
  default = "standard"
}

variable "azurerm_storage_account_replication_type" {
  type = string
  default = "GRS"
}

variable "azurerm_service_plan_name" {
  type = string
  default = "example"
}

variable "azurerm_service_plan_os_type" {
  type = string
  default = "Linux"
}

variable "azurerm_service_plan_sku_name" {
  type = string
  default = "P1v2"
}

variable "azurerm_linux_function_app_name" {
  type = string
  default = "example-linux-function-app"
}

variable "azurerm_function_app_function_name" {
  type = string
  default = "example-function-app-function"
}

variable "azurerm_function_app_function_language" {
  type = string
  default = "Python"
}


variable "test_data_name" {
  type = string
  default = "Azure"
}

variable "test_data_bindings" {
  type = list(object({
    authLevel = string
    direction = string
    methods   = list(string)
    name      = string
    type      = string
  }))
  default = [
    {
      authLevel = "function"
      direction = "in"
      methods   = ["get", "post"]
      name      = "req"
      type      = "httpTrigger"
    },
    {
      authLevel = ""
      direction = "out"
      methods   = []
      name      = "$return"
      type      = "http"
    }
  ]
}
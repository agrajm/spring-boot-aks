resource "azurerm_resource_group" "core" {
  name     = var.resource_group
  location = var.location
  tags = {
    environment = "training"
  }
}

resource "random_string" "randomstr" {
  length = 10
}
resource "azurerm_user_assigned_identity" "managed_identity" {
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location

  name = var.managed_identity_name
}
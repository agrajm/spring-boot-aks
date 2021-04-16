resource "azurerm_key_vault" "secretstore" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.core.location
  resource_group_name         = azurerm_resource_group.core.name
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  # Access Policy to assign GET & LIST secret access to Managed Identity
//  access_policy {
//    tenant_id = var.tenant_id
//    object_id = azurerm_user_assigned_identity.managed_identity.principal_id
//
//    secret_permissions = [
//      "Get","List"
//    ]
//  }

  depends_on = [azurerm_user_assigned_identity.managed_identity]
}
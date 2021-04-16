# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location
  address_space       = [var.vnet-address]
  tags = var.tags
}

resource "azurerm_subnet" "akssubnet" {
  name = var.aks-subnet-name
  resource_group_name = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.aks-subnet-address]

  service_endpoints = [
    "Microsoft.Sql"
  ]
}

resource "azurerm_sql_virtual_network_rule" "aksvnetrule" {
  name                = "aks-vnet-sql-rule"
  resource_group_name = azurerm_resource_group.core.name
  server_name         = azurerm_sql_server.sqlserver.name
  subnet_id           = azurerm_subnet.akssubnet.id
}

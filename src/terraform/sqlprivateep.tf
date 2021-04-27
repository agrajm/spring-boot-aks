
# Private Endpoint
resource "azurerm_private_endpoint" "sqlplink" {
  name                = "pe-sql-spboot"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  subnet_id           = azurerm_subnet.privateepsubnet.id

  private_service_connection {
    name                           = "sqlprivatelink"
    is_manual_connection           = "false"
    private_connection_resource_id = azurerm_sql_server.sqlserver.id
    subresource_names              = ["sqlServer"]
  }
}

# Private DNS Zone
resource "azurerm_private_dns_zone" "sql_plink_dns_private_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.core.name
}

# Use this data source to access the connection status information about an existing Private Endpoint Connection.
data "azurerm_private_endpoint_connection" "sql_plink_pe_conn" {
  name                = azurerm_private_endpoint.sqlplink.name
  resource_group_name = azurerm_private_endpoint.sqlplink.resource_group_name

  depends_on = [azurerm_private_endpoint.sqlplink]
}

# A Record for the Private DNS Zone - Maps the SQL Server with the Private IP from the Private Endpoint
resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = azurerm_sql_server.sqlserver.name
  zone_name           = azurerm_private_dns_zone.sql_plink_dns_private_zone.name
  resource_group_name = azurerm_private_endpoint.sqlplink.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.sql_plink_pe_conn.private_service_connection.0.private_ip_address]
}

# Linking the Private DNS Zone with our Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "sql_pe_vnet_link" {
  name = "sql-pe-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.sql_plink_dns_private_zone.name
  resource_group_name = azurerm_private_dns_zone.sql_plink_dns_private_zone.resource_group_name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

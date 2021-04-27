//
//# Private Endpoint
//resource "azurerm_private_endpoint" "kvplink" {
//  name                = "pe-kv-spboot"
//  location            = azurerm_resource_group.core.location
//  resource_group_name = azurerm_resource_group.core.name
//  subnet_id           = azurerm_subnet.privateepsubnet.id
//
//  private_service_connection {
//    name                           = "kvprivatelink"
//    is_manual_connection           = "false"
//    private_connection_resource_id = azurerm_key_vault.secretstore.id
//    subresource_names              = ["vault"]
//  }
//}
//
//# Private DNS Zone
//resource "azurerm_private_dns_zone" "kv_plink_dns_private_zone" {
//  name                = "privatelink.vaultcore.azure.net"
//  resource_group_name = azurerm_resource_group.core.name
//}
//
//# Use this data source to access the connection status information about an existing Private Endpoint Connection.
//data "azurerm_private_endpoint_connection" "kv_plink_pe_conn" {
//  name                = azurerm_private_endpoint.kvplink.name
//  resource_group_name = azurerm_private_endpoint.kvplink.resource_group_name
//
//  depends_on = [azurerm_private_endpoint.kvplink]
//}
//
//# A Record for the Private DNS Zone - Maps the Key Vault with the Private IP from the Private Endpoint
//resource "azurerm_private_dns_a_record" "kv_private_endpoint_a_record" {
//  name                = azurerm_key_vault.secretstore.name
//  zone_name           = azurerm_private_dns_zone.kv_plink_dns_private_zone.name
//  resource_group_name = azurerm_private_endpoint.kvplink.resource_group_name
//  ttl                 = 300
//  records             = [data.azurerm_private_endpoint_connection.sql_plink_pe_conn.private_service_connection.0.private_ip_address]
//}
//
//# Linking the Private DNS Zone with our Virtual Network
//resource "azurerm_private_dns_zone_virtual_network_link" "kv_pe_vnet_link" {
//  name = "kv-pe-vnet-link"
//  private_dns_zone_name = azurerm_private_dns_zone.kv_plink_dns_private_zone.name
//  resource_group_name = azurerm_private_dns_zone.kv_plink_dns_private_zone.resource_group_name
//  virtual_network_id = azurerm_virtual_network.vnet.id
//}

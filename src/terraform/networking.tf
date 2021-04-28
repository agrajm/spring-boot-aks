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
}

# Subnet for holding Private Endpoints for Azure services
resource "azurerm_subnet" "privateepsubnet" {
  name = "private-ep-subnet"
  resource_group_name                             = azurerm_resource_group.core.name
  virtual_network_name                            = azurerm_virtual_network.vnet.name
  address_prefixes                                = [var.private-ep-subnet-address]
  enforce_private_link_endpoint_network_policies  = true
}

# Subnet for Azure Firewall
resource "azurerm_subnet" "fwsubnet" {
  name = "AzureFirewallSubnet"
  resource_group_name                             = azurerm_resource_group.core.name
  virtual_network_name                            = azurerm_virtual_network.vnet.name
  address_prefixes                                = [var.az-fw-subnet-address]
}

# Route table: UDR for AKS Subnet to force traffic via Firewall
resource "azurerm_route_table" "rt" {
  name                = var.rt_name
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  disable_bgp_route_propagation = false

  route {
    name                   = "kubenetfw_fw_r"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }

  depends_on = [azurerm_firewall.fw]
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = azurerm_subnet.akssubnet.id
  route_table_id = azurerm_route_table.rt.id
}
resource "azurerm_public_ip" "bastionpip" {
  name                = "bastionpip"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = "examplebastion"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionpip.id
  }
}

#Subnet for Azure Bastion
resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.az-bastion-subnet-address]
}

//resource "azurerm_network_security_group" "nsg_bastion" {
//  name                = "nsg-group-bastion"
//  location            = azurerm_resource_group.core.location
//  resource_group_name = azurerm_resource_group.core.name
//}
//
//# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
//resource "azurerm_network_security_rule" "allow_ssh_from_bastion" {
//  name                        = "AllowOutputTCPFromBastionSubnet"
//  priority                    = 100
//  direction                   = "Outbound"
//  access                      = "Allow"
//  protocol                    = "Tcp"
//  source_port_range           = "*"
//  destination_port_range      = "80"
//  source_address_prefix       = var.az-bastion-subnet-address
//  destination_address_prefix  = "*"
//  resource_group_name         = azurerm_resource_group.core.name
//  network_security_group_name = azurerm_network_security_group.nsg_bastion.name
//}
//
//resource "azurerm_subnet_network_security_group_association" "subnet_nsg_vm_jb" {
//  subnet_id                 = azurerm_subnet.bastionsubnet.id
//  network_security_group_id = azurerm_network_security_group.nsg_bastion.id
//}

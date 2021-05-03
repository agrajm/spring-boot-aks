resource "azurerm_network_interface" "jumpbox" {
  name                = "jumpbox-nic"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jumpboxsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Subnet for Azure Jumpbox Subnet
resource "azurerm_subnet" "jumpboxsubnet" {
  name                 = "spboot2021am-jumpbox-subnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.az-jumpbox-subnet-address]
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                = "jumpbox-machine"
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location
  size                = "Standard_B2ms"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.jumpbox.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa_azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }
}

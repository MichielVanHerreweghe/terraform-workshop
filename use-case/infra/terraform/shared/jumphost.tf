resource "azurerm_public_ip" "jumphost_pip" {
  name                = "pip-vm-jump-${var.project}-${var.location_short_name}-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "jumphost_nsg" {
  name                = "nsg-vm-jump-${var.project}-${var.location_short_name}-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "jumphost_nic" {
  name                = "nic-vm-jump-${var.project}-${var.location_short_name}-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconf-jump-${var.project}-${var.location_short_name}-shared"
    subnet_id                     = azurerm_subnet.snet_vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumphost_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "jumphost_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.jumphost_nic.id
  network_security_group_id = azurerm_network_security_group.jumphost_nsg.id
}

resource "azurerm_linux_virtual_machine" "jumphost_vm" {
  name                            = "vm-jump-${var.project}-${var.location_short_name}-shared"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = var.jumphost_vm_size
  admin_username                  = var.jumphost_vm_admin_username
  admin_password                  = var.jumphost_vm_admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.jumphost_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-jump-${var.project}-${var.location_short_name}-shared"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
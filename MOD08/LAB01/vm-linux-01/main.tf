#coleta de dados azure kv
data "azurerm_key_vault" "kv-tfcurso" {
  name                = "kv-tfcurso-01"
  resource_group_name = "rg-tftec-kv"
}

data "azurerm_key_vault_secret" "tfcurso-secret" {
  name         = "tfcurso-secret"
  key_vault_id = data.azurerm_key_vault.kv-tfcurso.id
}

#VM LINUX
resource "azurerm_resource_group" "rg-tfcurso-linux" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_network_security_group" "nsg-tfcurso-linux" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg-tfcurso-linux.location
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux.name

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

resource "azurerm_virtual_network" "vnet-tfcurso-linux" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.rg-tfcurso-linux.location
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux.name
}

resource "azurerm_subnet" "sub-tfcurso-linux" {
  name                 = var.sub_name
  resource_group_name  = azurerm_resource_group.rg-tfcurso-linux.name
  address_prefixes     = var.sub_cidr
  virtual_network_name = azurerm_virtual_network.vnet-tfcurso-linux.name
}

resource "azurerm_public_ip" "pip-tfcurso-linux" {
  name                = var.pip_name
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux.name
  location            = azurerm_resource_group.rg-tfcurso-linux.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-tfcurso-linux" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg-tfcurso-linux.location
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub-tfcurso-linux.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-tfcurso-linux.id
  }
}

resource "azurerm_virtual_machine" "vm-tfcurso-linux" {
  name                  = var.vm_name
  location              = azurerm_resource_group.rg-tfcurso-linux.location
  resource_group_name   = azurerm_resource_group.rg-tfcurso-linux.name
  network_interface_ids = [azurerm_network_interface.nic-tfcurso-linux.id]
  vm_size               = var.sku_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm-linux-01"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.tfcurso-secret.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
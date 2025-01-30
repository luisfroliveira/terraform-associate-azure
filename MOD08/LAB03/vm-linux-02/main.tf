data "azurerm_key_vault" "kv-tfcurso" {
  name                = "kv-tfcurso-01"
  resource_group_name = "rg-tftec-kv"
}

data "azurerm_key_vault_secret" "tfcurso-secret" {
  name         = "tfcurso-secret"
  key_vault_id = data.azurerm_key_vault.kv-tfcurso.id
}

resource "azurerm_resource_group" "rg-tfcurso-linux-02" {
  name     = var.rg_name_02
  location = var.rg_location_02
}

resource "azurerm_network_security_group" "nsg-tfcurso-linux-02" {
  name                = var.nsg_name_02
  location            = azurerm_resource_group.rg-tfcurso-linux-02.location
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux-02.name

  dynamic "security_rule" {
    for_each = var.nsg_rules_02
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_virtual_network" "vnet-tfcurso-linux-02" {
  name                = var.vnet_name_02
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux-02.name
  location            = azurerm_resource_group.rg-tfcurso-linux-02.location
  address_space       = var.vnet_cidr_02
}

resource "azurerm_subnet" "sub-tfcurso-linux-02" {
  for_each             = toset(var.sub_names_02)
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg-tfcurso-linux-02.name
  virtual_network_name = azurerm_virtual_network.vnet-tfcurso-linux-02.name
  address_prefixes     = ["10.0.${(each.value == "sub-01") ? 1 : 2}.0/24"]
}

resource "azurerm_public_ip" "pip-tfcurso-linux-02" {
  count               = var.vm_count_02
  name                = "${var.pip_name_02}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux-02.name
  location            = azurerm_resource_group.rg-tfcurso-linux-02.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-tfcurso-linux-02" {
  count               = var.vm_count_02
  name                = "${var.nic_name_02}-${count.index + 1}"
  location            = azurerm_resource_group.rg-tfcurso-linux-02.location
  resource_group_name = azurerm_resource_group.rg-tfcurso-linux-02.name

  ip_configuration {
    name                          = "internal-${count.index + 1}"
    subnet_id                     = azurerm_subnet.sub-tfcurso-linux-02[sub_names_02[count.index]].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-tfcurso-linux-02[count.index].id
  }
}

resource "azurerm_virtual_machine" "vm-tfcurso-linux-02" {
  count                 = var.vm_count_02
  name                  = "${var.vm_name_linux_02}-${count.index + 1}"
  location              = azurerm_resource_group.rg-tfcurso-linux-02.location
  resource_group_name   = azurerm_resource_group.rg-tfcurso-linux-02.name
  network_interface_ids = [azurerm_network_interface.nic-tfcurso-linux-02[count.index].id]
  vm_size               = var.sku_size_02

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm-linux-${count.index + 1}"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.tfcurso-secret.value
  }

  connection {
    type = "ssh"
    host = azurerm_public_ip.pip-tfcurso-linux-02[count.index].public_ip_address
    user = "adminuser"
    password = data.azurerm_key_vault_secret.tfcurso-secret.value
  }
  
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags_02
}
rg_name_win     = "rf-tftec-win"
rg_location_win = "eastus"
nsg_name_win    = "nsg-tftec-win-01"
nsg_rules_win = [
  {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "RDP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
vnet_name_win          = "vnet-tftec-win-01"
vnet_cidr_win          = ["10.0.0.0/16"]
snet_name_win          = "snet-tftec-win"
snet_cidr_win          = ["10.0.1.0/24", "10.0.2.0/24"]
pip_name_win           = "pip-tftec-win-01"
nic_name_win           = "ni-tftec-win-01"
vm_name_win            = "vm-tftec-win-01"
sku_size_win           = "Standard_DS1_v2"
data_disk_sizes_win    = [128, 256]
provision_vm_agent_win = true
tags_win = {
  ambiente = "prod"
  projeto  = "terraform"
  empresa  = "tftec"
}      
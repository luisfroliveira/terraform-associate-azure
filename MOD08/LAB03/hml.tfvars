rg_name_02     = "rg-tfcurso-linux-02"
rg_location_02 = "eastus"
nsg_name_02    = "nsg-tfcurso-linux-02"
nsg_rules_02 = [
  {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

vnet_name_02     = "vnet-tfcurso-linux-02"
vnet_cidr_02     = ["10.0.2.0/24"]
sub_names_02     = ["sub-01", "sub-02"]
vm_count_02      = 2
pip_name_02      = "pip-tfcurso-linux-02"
nic_name_02      = "nic-tfcurso-linux-02"
vm_name_linux_02 = "vm-tfcurso-linux-02"
sku_size_02      = "Standard_DS1_v2"
tags_02 = {
  ambiente = "hml"
  projeto  = "terrfarom"
  empresa  = "tfcurso"
}
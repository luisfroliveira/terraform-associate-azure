module "vm-linux-02" {
  source = "./vm-linux-02"

  rg_name_02       = var.rg_name_02
  rg_location_02   = var.rg_location_02
  nsg_name_02      = var.nsg_name_02
  nsg_rules_02     = var.nsg_rules_02
  vnet_name_02     = var.vnet_name_02
  vnet_cidr_02     = var.vnet_cidr_02
  sub_names_02     = var.sub_names_02
  vm_count_02      = var.vm_count_02
  pip_name_02      = var.pip_name_02
  nic_name_02      = var.nic_name_02
  vm_name_linux_02 = var.vm_name_linux_02
  sku_size_02      = var.sku_size_02
  tags_02          = var.tags_02
}
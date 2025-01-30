variable "rg_name_02" {
  type = string
}

variable "rg_location_02" {
  type = string
}

variable "nsg_name_02" {
  type = string
}

variable "nsg_rules_02" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "vnet_name_02" {
  type = string
}

variable "vnet_cidr_02" {
  type = list(string)
}

variable "sub_names_02" {
  type    = list(string)
  default = ["sub-01", "sub-02"]
}

variable "vm_count_02" {
  type = string
}

variable "pip_name_02" {
  type = string
}

variable "nic_name_02" {
  type = string
}

variable "vm_name_linux_02" {
  type = string
}

variable "sku_size_02" {
  type = string
}

variable "tags_02" {
  type = map(any)
}
variable "rg_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "rg_location" {
  description = "Localização do grupo de recursos"
  type        = string
}

variable "nsg_name" {
  description = "Nome do grupo de segurança de rede"
  type        = string
}

variable "vnet_name" {
  description = "Nome da rede virtual"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR da rede virtual"
  type        = list(string)
}
variable "sub_name" {
  description = "Nome da sub-rede"
  type        = string
}

variable "sub_cidr" {
  description = "CIDR da sub-rede"
  type        = list(string)
}

variable "pip_name" {
  description = "Nome do IP público"
  type        = string
}

variable "nic_name" {
  description = "Nome da interface de rede"
  type        = string
}

variable "vm_name" {
  description = "Nome da máquina virtual"
  type        = string
}

variable "sku_size" {
  description = "Tamanho da VM"
  type        = string
}
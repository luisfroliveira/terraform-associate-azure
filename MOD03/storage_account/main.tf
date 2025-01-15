#DATA BLOCK
data "azurerm_resource_group" "rg-portal" {
  name = "RG-TFTEC-DATA-BLOCK-PORTAL"
}

#LOCAL VARIABLE BLOCK
locals {
  storage_account_sku = "Standard"
}

#RESOURCE BLOCK
resource "azurerm_storage_account" "storage_tftec" {
  name                     = "stgtftec${random_string.random.result}"
  resource_group_name      = data.azurerm_resource_group.rg-portal.name
  location                 = data.azurerm_resource_group.rg-portal.location
  account_tier             = local.storage_account_sku
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

#VARIABLE BLOCK
variable "account_replication_type" {
  description = "Tipo de replica da storage account"
  type        = string
  default     = "GRS"
}

#OUTPUT BLOCK
output "storage_account_id" {
  value = azurerm_storage_account.storage_tftec.id
}

#RANDOM BLOCK
resource "random_string" "random" {
  length = 5
  special = false
  upper = false
}
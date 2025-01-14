terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}

# module block
module "storage_module" {
  source = "./storage_account"
}

#OUTPUT BLOCK
output "storage_account_id" {
  value = module.storage_module.storage_account_id
}
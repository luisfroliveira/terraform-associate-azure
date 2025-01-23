terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
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

# module dns zone
module "dns_zone_module" {
  source = "./dns_zone"
  dns_name = "tfteclab1993.com.br"
  rg_name = module.rg_module
}

# terrafomr output values block dns'
output "dns_id" {
  value = module.dns_module.dns_id
}
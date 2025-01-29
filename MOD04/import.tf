# Resource Group Import without automatic code generation 
import {
  to = module.rg_module.azurerm_resource_group.rg-import
  id = "RG_ID"
}

# Public IP Import with automatic code generation 
import {
  to = azurerm_public_ip.pip-tftec-import
  id = "PIP_ID"
}
resource "azurerm_resource_group" "rg-import" {
  name = "rg-tftec-import-portalq"
  location = "eastus"
  tags = {
    import = "OK"
  }
}
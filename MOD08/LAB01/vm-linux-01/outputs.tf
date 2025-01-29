output "secret_value" {
  value     = data.azurerm_key_vault_secret.tfcurso-secret.value
  sensitive = true
}

output "ip_address" {
  value = azurerm_public_ip.pip-tfcurso-linux.ip_address
}
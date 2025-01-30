output "all_publics_ips" {
  value = azurerm_public_ip.pip-tfcurso-linux-02[*].ip_address
}
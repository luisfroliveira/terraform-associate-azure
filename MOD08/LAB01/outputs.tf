output "secret_value" {
  value     = module.vm-linux-01.secret_value
  sensitive = true
}

output "ip_address" {
  value = module.vm-linux-01.ip_address
}
# Instalação do Internet Information Services (IIS)
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Configuração do Firewall para permitir o tráfego HTTP (porta 80)
New-NetFirewallRule -Name "AllowHTTP" -Protocol TCP -LocalPort 80 -Action Allow

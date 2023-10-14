output "staging_pip" {
  value = azurerm_public_ip.jenkins_ip.ip_address
}

output "staging_monitor_pip" {
  value = azurerm_public_ip.ansible_ip.ip_address
}

output "staging_pip_nat" {
  value = azurerm_public_ip.k8s_ip.ip_address
}

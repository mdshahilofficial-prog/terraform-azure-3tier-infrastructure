output "public_ip_ids" {
  description = "Map of public IP keys to public IP IDs."

  value = {
    for key, pip in azurerm_public_ip.pip :
    key => pip.id
  }
}
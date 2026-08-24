output "network_security_group_ids" {
  description = "Map of NSG keys to NSG IDs."

  value = {
    for key, nsg in azurerm_network_security_group.nsg :
    key => nsg.id
  }
}
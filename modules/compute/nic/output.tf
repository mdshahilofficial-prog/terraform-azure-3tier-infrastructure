output "network_interface_ids" {
  description = "Map of network interface keys to network interface IDs."

  value = {
    for key, nic in azurerm_network_interface.nic :
    key => nic.id
  }
}
output "subnet_ids" {
  description = "Map of subnet keys to subnet IDs."

  value = {
    for key, snet in azurerm_subnet.snet :
    key => snet.id
  }
}
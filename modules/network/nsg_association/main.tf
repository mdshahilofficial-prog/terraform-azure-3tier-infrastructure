resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  for_each = var.subnet_nsg_associations

  subnet_id                 = each.value.subnet_id
  network_security_group_id = each.value.network_security_group_id
}
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each = var.nic_nsg_associations

  network_interface_id      = each.value.network_interface_id
  network_security_group_id = each.value.network_security_group_id
}
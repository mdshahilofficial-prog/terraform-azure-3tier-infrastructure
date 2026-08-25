resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastions

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku

  ip_configuration {
    name                 = "${each.value.name}-ipconfig"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }
}
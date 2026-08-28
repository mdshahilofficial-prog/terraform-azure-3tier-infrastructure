resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.linux_vms

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username

  network_interface_ids = [
    each.value.nic_id
  ]

  computer_name = each.value.computer_name

  admin_password = data.azurerm_key_vault_secret.linux_vm_password[each.key].value

  disable_password_authentication = each.value.ssh_public_key != null

  dynamic "admin_ssh_key" {
    for_each = each.value.ssh_public_key != null ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = each.value.ssh_public_key
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = each.value.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "vm" {
  for_each = var.windows_vms

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username

  admin_password = data.azurerm_key_vault_secret.windows_vm_password[each.key].value

  network_interface_ids = [
    each.value.nic_id
  ]

  computer_name = each.value.computer_name

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = each.value.os_disk_size_gb
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }
}
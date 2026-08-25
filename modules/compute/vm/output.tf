output "linux_vm_ids" {
  description = "Map of Linux VM keys to VM IDs."

  value = {
    for key, vm in azurerm_linux_virtual_machine.vm :
    key => vm.id
  }
}

output "windows_vm_ids" {
  description = "Map of Windows VM keys to VM IDs."

  value = {
    for key, vm in azurerm_windows_virtual_machine.vm :
    key => vm.id
  }
}
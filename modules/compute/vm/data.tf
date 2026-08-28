data "azurerm_key_vault_secret" "linux_vm_password" {
  for_each = var.linux_vms

  name         = split("/", each.value.key_vault_secret_id)[5]
  key_vault_id = join("/", slice(split("/", each.value.key_vault_secret_id), 0, 5))
}
data "azurerm_key_vault_secret" "windows_vm_password" {
  for_each = var.windows_vms

  name         = split("/", each.value.key_vault_secret_id)[5]
  key_vault_id = join("/", slice(split("/", each.value.key_vault_secret_id), 0, 5))
}
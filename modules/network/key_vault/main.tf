resource "azurerm_key_vault" "kv" {
  for_each = var.key_vaults

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tenant_id           = each.value.tenant_id

  sku_name                   = each.value.sku_name
  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  rbac_authorization_enabled = true

  tags = each.value.tags
}


resource "azurerm_key_vault_secret" "secret" {
  for_each = var.key_vault_secrets

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.key_vault_key].id
}


resource "azurerm_role_assignment" "kv_role" {
  for_each = var.key_vault_role_assignments

  scope                = azurerm_key_vault.kv[each.value.key_vault_key].id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}
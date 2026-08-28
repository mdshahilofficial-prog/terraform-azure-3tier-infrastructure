output "key_vault_ids" {
  description = "Key Vault IDs."

  value = {
    for key, kv in azurerm_key_vault.kv :
    key => kv.id
  }
}


output "key_vault_secret_ids" {
  description = "Key Vault secret IDs."

  value = {
    for key, secret in azurerm_key_vault_secret.secret :
    key => secret.id
  }
}
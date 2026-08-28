variable "key_vaults" {
  description = "Key Vaults to create."

  type = map(object({
    name                       = string
    resource_group_name        = string
    location                   = string
    tenant_id                  = string
    sku_name                   = optional(string, "standard")
    soft_delete_retention_days = optional(number, 7)
    purge_protection_enabled   = optional(bool, false)
    tags                       = optional(map(string), {})
  }))
}


variable "key_vault_secrets" {
  description = "Key Vault secrets to create."

  type = map(object({
    name          = string
    value         = string
    key_vault_key = string
  }))
}


variable "key_vault_role_assignments" {
  description = "Key Vault RBAC role assignments."

  type = map(object({
    key_vault_key       = string
    role_definition_name = string
    principal_id        = string
  }))
}
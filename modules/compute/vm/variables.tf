variable "linux_vms" {
  description = "Linux virtual machines."

  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    size                 = string
    admin_username       = string
    nic_key              = string
    computer_name        = string
    os_disk_size_gb      = number
    ssh_public_key       = optional(string)
    key_vault_secret_key = string
  }))
}


variable "windows_vms" {
  description = "Windows virtual machines."

  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    size                 = string
    admin_username       = string
    nic_key              = string
    computer_name        = string
    os_disk_size_gb      = number
    key_vault_secret_key = string
  }))
}


variable "key_vault_secret_values" {
  description = "Key Vault secret values used by virtual machines."

  type      = map(string)
  sensitive = true
}
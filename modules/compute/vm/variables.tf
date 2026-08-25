variable "linux_vms" {
  description = "Linux virtual machines to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    admin_password      = optional(string)
    ssh_public_key      = optional(string)
    nic_id              = string
    computer_name       = optional(string)
    os_disk_size_gb     = optional(number, 30)
  }))

  default = {}
}


variable "windows_vms" {
  description = "Windows virtual machines to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    admin_password      = string
    nic_id              = string
    computer_name       = optional(string)
    os_disk_size_gb     = optional(number, 128)
  }))

  default = {}
}
variable "resource_groups" {
  description = "Resource groups to create."
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
}


variable "virtual_networks" {
  description = "Virtual networks to create."
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    tags                = optional(map(string))
  }))
}


variable "subnets" {
  description = "Subnets to create."

  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


variable "public_ips" {
  description = "Public IP addresses to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = string
  }))
}


variable "bastions" {
  description = "Azure Bastion hosts to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string

    subnet_key    = string
    public_ip_key = string
  }))
}


variable "network_security_groups" {
  description = "Network Security Groups and their security rules."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      description                = optional(string)
    }))
  }))
}


variable "subnet_nsg_associations" {
  description = "Subnet to NSG associations."

  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))

  default = {}
}


variable "nic_nsg_associations" {
  description = "NIC to NSG associations."

  type = map(object({
    nic_key = string
    nsg_key = string
  }))

  default = {}
}


variable "network_interfaces" {
  description = "Network interfaces to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_key          = string
  }))
}


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
    nic_key             = string
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
    nic_key             = string
    computer_name       = optional(string)
    os_disk_size_gb     = optional(number, 128)
  }))

  default = {}
}


variable "sql_servers" {
  description = "Azure SQL logical servers to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    administrator_login = string
    version             = string
  }))
}


variable "sql_databases" {
  description = "Azure SQL databases to create."

  type = map(object({
    name           = string
    server_key     = string
    sku_name       = string
    max_size_gb    = optional(number, 32)
    zone_redundant = optional(bool, false)
  }))
}


variable "sql_admin_password" {
  description = "Azure SQL administrator password."

  type      = string
  sensitive = true
}


variable "ssh_public_key" {
  description = "SSH public key used for Linux virtual machines."

  type      = string
  sensitive = false
}
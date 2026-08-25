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
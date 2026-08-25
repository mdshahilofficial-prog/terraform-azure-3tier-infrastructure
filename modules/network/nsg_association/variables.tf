variable "subnet_nsg_associations" {
  description = "NSG associations for subnets."

  type = map(object({
    subnet_id                 = string
    network_security_group_id = string
  }))

  default = {}
}


variable "nic_nsg_associations" {
  description = "NSG associations for network interfaces."

  type = map(object({
    network_interface_id      = string
    network_security_group_id = string
  }))

  default = {}
}
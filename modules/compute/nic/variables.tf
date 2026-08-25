variable "network_interfaces" {
  description = "Network interfaces to create."

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_id           = string
  }))
}
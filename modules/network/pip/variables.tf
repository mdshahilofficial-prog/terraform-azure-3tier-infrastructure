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
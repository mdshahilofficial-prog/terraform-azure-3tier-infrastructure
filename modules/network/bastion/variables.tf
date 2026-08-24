variable "bastions" {
  description = "Azure Bastion hosts to create."

  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    sku                  = string
    subnet_id            = string
    public_ip_address_id = string
  }))
}
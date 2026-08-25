variable "sql_servers" {
  description = "Azure SQL logical servers to create."

  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    version                      = string
  }))
}
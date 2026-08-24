variable "sql_databases" {
  description = "Azure SQL databases to create."

  type = map(object({
    name           = string
    server_id      = string
    sku_name       = string
    max_size_gb    = optional(number, 32)
    zone_redundant = optional(bool, false)
  }))
}
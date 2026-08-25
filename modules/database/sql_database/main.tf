resource "azurerm_mssql_database" "sql_db" {
  for_each = var.sql_databases

  name           = each.value.name
  server_id      = each.value.server_id
  sku_name       = each.value.sku_name
  max_size_gb    = each.value.max_size_gb
  zone_redundant = each.value.zone_redundant
}
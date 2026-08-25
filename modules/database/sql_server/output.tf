output "sql_server_ids" {
  description = "Map of SQL server keys to SQL server IDs."

  value = {
    for key, server in azurerm_mssql_server.sql_server :
    key => server.id
  }
}
output "sql_server_fqdns" {
  description = "Map of SQL server keys to fully qualified domain names."

  value = {
    for key, server in azurerm_mssql_server.sql_server :
    key => server.fully_qualified_domain_name
  }
}
output "sql_database_ids" {
  description = "Map of SQL database keys to database IDs."

  value = {
    for key, db in azurerm_mssql_database.sql_db :
    key => db.id
  }
}
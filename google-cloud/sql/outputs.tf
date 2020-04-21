###############################################################################
## SQL Database
###############################################################################
output "database_instance" {
  value = google_sql_database.google_sql_database-module.instance
}

output "database_name" {
  value = google_sql_database.google_sql_database-module.name
}

output "database_project" {
  value = google_sql_database.google_sql_database-module.project
}

###############################################################################
## SQL Master Instance
###############################################################################
output "database_master_connection_name" {
  value = google_sql_database_instance.google_sql_database_instance-module-master.connection_name
}

output "database_master_first_ip_address" {
  value = google_sql_database_instance.google_sql_database_instance-module-master.first_ip_address
}

###############################################################################
## SQL User
###############################################################################
output "database_user_name" {
  value = google_sql_user.google_sql_user-module.name
}

output "database_user_password" {
  value = google_sql_user.google_sql_user-module.password
}

resource "google_sql_database" "google_sql_database-module" {
  name     = "${var.database_name == "UNSET" ? var.service_name : var.database_name}"
  charset  = "${var.database_charset}"
  instance = "${google_sql_database_instance.google_sql_database_instance-module-master.name}"
}

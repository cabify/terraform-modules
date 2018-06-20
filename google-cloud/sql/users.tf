resource "google_sql_user" "google_sql_user-module" {
  // Throw an error if username is too long
  name       = "${length(var.user_name) <= 16 ? var.user_name : ""}"
  host       = "${var.user_host}"
  password   = "${var.user_password}"
  instance   = "${google_sql_database_instance.google_sql_database_instance-module-master.name}"
  depends_on = ["google_sql_database_instance.google_sql_database_instance-module-failover"]
}

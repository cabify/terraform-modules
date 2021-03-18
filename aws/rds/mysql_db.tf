# Create a second database, in addition to the "initial_db" created
# by the aws_db_instance resource above.
resource "mysql_database" "appdb" {
  name = var.service_name == "UNSET" ? var.instance_name : var.service_name
  default_character_set = "utf8mb4"
  default_collation = "utf8mb4_general_ci"
}

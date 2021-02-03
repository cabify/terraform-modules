resource "aws_db_option_group" "rds" {
  name                 = var.instance_name
  engine_name          = var.engine_name
  major_engine_version = var.major_engine_version

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }


  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name  = "SERVER_AUDIT_EVENTS"
      value = "CONNECT"
    }
  }
}

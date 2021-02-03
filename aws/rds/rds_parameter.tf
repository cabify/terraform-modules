resource "aws_db_parameter_group" "rds" {
  name   = var.instance_name
  family = var.family
  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }
  dynamic "parameter" {
    for_each = var.db_parameter
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}

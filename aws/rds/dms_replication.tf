//
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance
//


# subnet group
resource "aws_dms_replication_subnet_group" "replication-subnet-group" {
  replication_subnet_group_description = "Replication subnet group for ${var.instance_name}"
  replication_subnet_group_id          = "dms-subnet-group-${var.instance_name}"

  subnet_ids = var.db_subnet_group_subnet_ids

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }

}

# instance
resource "aws_dms_replication_instance" "replicate" {
  count                      = var.replication_enabled == true ? 1 : 0
  replication_instance_id    = "${var.instance_name}-replication-instance"
  replication_instance_class = lookup(local.dms_instance_map, var.instance_class, "instance-not-found")

  replication_subnet_group_id = aws_dms_replication_subnet_group.replication-subnet-group.id
  vpc_security_group_ids      = var.vpc_security_group_ids

  allocated_storage          = var.allocated_storage
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.tier == "3" ? true : false
  // multi_az                     = var.tier == "3" ? false : true
  multi_az                     = false // we control the failover time, so HA not necessary
  preferred_maintenance_window = var.maintenance_window
  publicly_accessible          = true

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }

}

# RDS
resource "aws_dms_endpoint" "target" {
  count         = var.replication_enabled == true ? 1 : 0
  endpoint_id   = "${var.instance_name}-target"
  endpoint_type = "target"
  engine_name   = "mysql"

  server_name = aws_db_instance.primary.address
  username    = var.dbadmin_username
  password    = var.dbadmin_password
  port        = var.port
  // ssl_mode    = "require"

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }
}

# GCP
resource "aws_dms_endpoint" "source" {
  count         = var.replication_enabled == true ? 1 : 0
  endpoint_id   = "${var.instance_name}-source"
  endpoint_type = "source"
  engine_name   = "mysql"

  server_name = var.replication_gcp_endpoint
  username    = var.replication_gcp_username
  password    = var.replication_gcp_password
  port        = "3306" // cloudsql hardcode
  // ssl_mode    = "none"

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }
}

# Create a new replication task
resource "aws_dms_replication_task" "replicate" {
  count               = var.replication_enabled == true ? 1 : 0
  replication_task_id = "${var.instance_name}-task"

  migration_type = "full-load-and-cdc"

  replication_instance_arn = aws_dms_replication_instance.replicate[count.index].replication_instance_arn
  source_endpoint_arn      = aws_dms_endpoint.source[count.index].endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target[count.index].endpoint_arn

  // https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.html
  table_mappings = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"${var.replication_gcp_database}\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"

  // https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TaskSettings.html
  // live in data.tf
  replication_task_settings = local.dms_replicat_task_settings

  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }

}

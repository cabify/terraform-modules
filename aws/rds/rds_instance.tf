# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE DATABASE INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_db_instance" "primary" {
  // general 
  identifier              = var.instance_name
  username                = var.dbadmin_username
  password                = var.dbadmin_password
  apply_immediately       = var.apply_immediately
  maintenance_window      = var.maintenance_window
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  skip_final_snapshot     = true
  license_model           = var.license_model
  tags = {
    Name    = var.instance_name
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }

  // network
  port                   = var.port
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.public_access

  // mysql specific 
  engine                      = var.engine_name
  engine_version              = var.engine_version
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = var.tier == "3" ? true : false
  parameter_group_name        = aws_db_parameter_group.rds.id
  option_group_name           = aws_db_option_group.rds.id

  // instance configs
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true
  storage_type          = var.storage_type
  iops                  = var.storage_type == "io1" ? var.iops : null
  multi_az              = var.tier == "3" ? false : true

  // monitoring
  monitoring_interval          = 60
  monitoring_role_arn          = "arn:aws:iam::${var.aws_account_nr}:role/rds-monitoring-role"
  performance_insights_enabled = var.tier == "3" ? false : true
  // performance_insights_retention_period = 7
}

resource "aws_db_instance" "read-replica" {
  count = var.read_only_replicas

  identifier          = "${var.instance_name}-read-replica-${count.index + 1}"
  apply_immediately   = var.apply_immediately
  maintenance_window  = var.maintenance_window
  skip_final_snapshot = true
  license_model       = var.license_model
  // general 
  tags = {
    Name    = "${var.instance_name}-read-replica-${count.index + 1}"
    Service = var.service_name == "UNSET" ? var.instance_name : var.service_name
    Owner   = var.owner
    Tier    = var.tier
  }

  // network
  port                   = var.port
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.public_access

  // mysql specific 
  engine                      = var.engine_name
  engine_version              = var.engine_version
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = var.tier == "3" ? true : false
  parameter_group_name        = aws_db_parameter_group.rds.id
  option_group_name           = aws_db_option_group.rds.id

  // instance configs
  instance_class        = var.read_only_replica_instance_class == "UNSET" ? var.instance_class : var.read_only_replica_instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true
  storage_type          = var.storage_type
  iops                  = var.storage_type == "io1" ? var.iops : null

  // monitoring
  monitoring_interval          = 60
  monitoring_role_arn          = "arn:aws:iam::${var.aws_account_nr}:role/rds-monitoring-role"
  performance_insights_enabled = var.tier == "3" ? false : true

  // Replica
  replicate_source_db = aws_db_instance.primary.id
}

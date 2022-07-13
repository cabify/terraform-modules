# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# Given these are credentials, security of the values should be considered.
# ---------------------------------------------------------------------------------------------------------------------

variable "dbadmin_username" {
  description = "Master username of the DB"
  type        = string
}

variable "dbadmin_password" {
  description = "Master password of the DB"
  type        = string
}

variable "application_username" {
  description = "application username of the DB"
  type        = string
}

variable "application_password" {
  description = "application password of the DB"
  type        = string
}

variable "exporter_username" {
  description = "exporter password of the DB (username: exporter)"
  type        = string
  default     = "exporter"
}

variable "exporter_password" {
  description = "exporter password of the DB (username: exporter)"
  type        = string
}

variable "instance_name" {
  description = "Name of the database to be created"
  type        = string
}

variable "bastion_host" {
  description = "Bastion host to jump into to connect to the RDS instance"
  type        = string
}

variable "bastion_port" {
  description = "Bastion port to jump into to connect to the RDS instance"
  type        = number
}

variable "bastion_user" {
  description = "Bastion user to jump into to connect to the RDS instance"
  type        = string
}

variable "tls_cert" {
  description = "TLS cert file to use on the bastion jump into to connect to the RDS instance"
  type        = string
}

variable "owner" {
  description = "Name of team who owns the service"
  type        = string
}

variable "tier" {
  description = "Name of tier (1.2.3)"
  type        = string
}

variable "instance_class" {
  type        = string
  description = "Class of instance: https://aws.amazon.com/rds/instance-types/"
}

variable "aws_account" {
  type        = string
  description = "account name to be used"
}

variable "aws_account_nr" {
  type        = string
  description = "account number to be used"
}

variable "db_subnet_group_name" {
  type        = string
  description = "pass in from data source"
}

variable "dms_subnet_group_id" {
  type        = string
  description = "pass in from data source"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "pass in from data source"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS: General
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "service_name" {
  description = "Name of the service accessing this db - if not specified, instance_name will be used"
  type        = string
  default     = "UNSET"
}

variable "license_model" {
  description = "License model of the DB instance"
  type        = string
  default     = "general-public-license"
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = true
}

variable "port" {
  description = "Port which the database should run on"
  type        = number
  default     = 3306
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS: GCP migration
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "replication_enabled" {
  description = "is this a replication client"
  type        = bool
  default     = false
}

variable "replication_gcp_username" {
  description = "replication username of the DB"
  type        = string
  default     = "UNSET"
}

variable "replication_gcp_password" {
  description = "replication password of the DB (username: repl)"
  type        = string
  default     = "UNSET"
}

variable "replication_gcp_endpoint" {
  description = "ip of cloudsql instance"
  type        = string
  default     = "UNSET"
}

variable "replication_gcp_database" {
  description = "db on the cloudsql instance"
  type        = string
  default     = "UNSET"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS: Readonly replicas
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "read_only_replicas" {
  description = "Number of read only replicas to create"
  default     = 0
}

variable "read_only_replica_instance_class" {
  type        = string
  description = "class of readonly replicas to create"
  default     = "UNSET"
}

variable "read_only_replica_engine_version" {
  description = "Engine version of the database replicas to be launched"
  type        = string
  default     = "UNSET"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS: Monitoring
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "namespace" {
  description = "Name of kubernetes namespace"
  type        = string
  default     = "prometheus-persistence"
}

variable "prometheus-scrape-flag" {
  description = "Annotation for prometheus to scrape the service by"
  type        = string
  default     = "persistence"
}

variable "region" {
  description = "Region name for the rds_exporter"
  type        = string
  default     = "us-east-1"
}

variable "cloudwatch_enabled" {
  description = "Cloudwatch deployment and service enabled"
  type        = bool
  default     = false
}

variable "cloudwatch_enhanced_enabled" {
  description = "Cloudwatch enhanced deployment and service enabled"
  type        = bool
  default     = false
}

# This is a variable as `/health` is only available through Cabify fork upstream is `/basic`
variable "rds_exporter_health_path" {
  description = "Path to setup liveness probe against RDS exporter"
  type        = string
  default     = "/health"
}

variable "sql_exporter_enabled" {
  description = "Set up a SQL exporter side care to export metrics base on SQL queries"
  type        = bool
  default     = false
}

variable "exporter_collector_flags" {
  type = list(string)
  default = [
    "--collect.info_schema.clientstats",
    "--collect.info_schema.processlist",
    "--collect.engine_innodb_status",
    "--collect.info_schema.innodb_metrics"
  ]
  description = "A list of configuration collectors flags for the exporter. https://github.com/prometheus/mysqld_exporter/blob/master/README.md#collector-flags"
}

variable "exporter_collector_perf_flags" {
  type = list(string)
  default = [
    "--collect.perf_schema.eventsstatements",
    "--collect.perf_schema.eventswaits",
    "--collect.perf_schema.file_events",
    "--collect.perf_schema.indexiowaits",
    "--collect.perf_schema.preparedstatements",
    "--collect.perf_schema.tableiowaits",
    "--collect.perf_schema.tablelocks"
  ]
  description = "A list of configuration collectors flags for the exporter performance wise. https://github.com/prometheus/mysqld_exporter/blob/master/README.md#collector-flags"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS: MySQL Instance Variables
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------


variable "engine_name" {
  description = "Name of the database engine"
  type        = string
  default     = "mysql"
}

variable "family" {
  description = "Family of the database"
  type        = string
  default     = "mysql5.7"
}

variable "major_engine_version" {
  description = "MAJOR.MINOR version of the DB engine"
  type        = string
  default     = "5.7"
}

variable "engine_version" {
  description = "Version of the database to be launched"
  default     = "5.7"
  type        = string
}

variable "db_parameter" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default = [
    { apply_method = "immediate", name = "general_log", value = "0" },
    { apply_method = "immediate", name = "query_cache_size", value = "0" }
  ]
  description = "A list of DB parameters to apply. Note that parameters may differ from a DB family to another. apply_method - (Optional) \"immediate\" (default), or \"pending-reboot\". Some engines can't apply some parameters without a reboot, and you will need to specify \"pending-reboot\" here."
}

#
# Storage
#

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = "gp2"
}

variable "iops" {
  type        = number
  description = "IOPS to be provisioned if using type io1. Disk must be larger than 100G"
  default     = null
}

variable "allocated_storage" {
  description = "Disk space to be allocated to the DB instance"
  type        = number
  default     = 10
}

variable "max_allocated_storage" {
  description = "Disk space to be at max allocated to the DB instance - enabling autoscale"
  type        = number
  default     = 1024
}

#
# Backups
#
variable "backup_retention_period" {
  type        = number
  description = "Backup retention period in days. Must be > 0 to enable backups"
  default     = 7
}

variable "backup_window" {
  type        = string
  description = "When AWS can perform DB snapshots, can't overlap with maintenance window"
  default     = "00:00-06:00"
}

#
# Maintenance
#
variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "mon:10:00-mon:11:00"
}


###
# testing only
###
variable "public_access" {
  type    = bool
  default = false
}

variable "service_name" {
  description = "Name of the service - will be used for instance names"
  type        = "string"
}

variable "database_charset" {
  description = "Database character set - default should be correct"
  type        = "string"
  default     = "utf8"
}

variable "database_engine_version" {
  description = "Type of database to use - We currently use 5.7 everywhere"
  type        = "string"
  default     = "MYSQL_5_7"
}

variable "database_name" {
  description = "Name of the database - if not set, service_name is used"
  type        = "string"
  default     = "UNSET"
}

variable "user_host" {
  description = "Hosts the user is allowed to connect from"
  type        = "string"
  default     = "%"
}

variable "user_name" {
  description = "Username for the db (16 char max length)"
  type        = "string"
}

variable "user_password" {
  description = "Clear text password for db user"
  type        = "string"
}

variable "instance_maintenance_day" {
  description = "Day of the week to perform maintenance (mon-sun = 1-7)"
  default    = 1
}

variable "instance_maintenance_hour" {
  description = "Hour of the day to perform maintenance (0-23)"
  default    = 8
}

variable "instance_maintenance_update_track" {
  description = "Receive updates earlier (canary) or later (stable)"
  type       = "string"
  default    = "canary"
}

variable "instance_disk_autoresize" {
  description = "Will the disk autosize to the usage"
  default     = true
}

variable "instance_disk_size" {
  description = "Size in Gb of the disk"
  default     = 10
}

variable "instance_disk_type" {
  description = "Disk backend to use - PD_HDD or PD_SSD"
  type        = "string"
}

variable "instance_failover_members" {
  description = "Number of failover instances to start"
  default     = 1
}

variable "instance_read_only_replica_count" {
  description = "Number of read only replicas to create"
  default     = 0
}

variable "instance_region" {
  description = "Where to start the instances"
  type        = "string"
}

variable "instance_tier" {
  description = "Type of instance to use - see https://cloud.google.com/sql/pricing#2nd-gen-instance-pricing"
  type        = "string"
}

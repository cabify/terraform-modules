variable "service_name" {
  type = "string"
}

variable "database_charset" {
  type    = "string"
  default = "utf8"
}

variable "database_engine_version" {
  type    = "string"
  default = "MYSQL_5_7"
}

variable "database_name" {
  type    = "string"
  default = "UNSET"
}

variable "user_host" {
  description = "hosts the user is allowed to connect from"
  type        = "string"
  default     = "%"
}

variable "user_name" {
  description = "username for the db (16 char max length)"
  type        = "string"
}

variable "user_password" {
  description = "clear text password for db user"
  type        = "string"
}

variable "instance_days_of_the_week" {
  type = "map"

  default = {
    monday    = 1
    tuesday   = 2
    wednesday = 3
    thursday  = 4
    friday    = 5
    saturday  = 6
    sunday    = 7
  }
}

variable "instance_disk_autoresize" {
  default = true
}

variable "instance_disk_size" {
  description = "size in Gb of the disk"
  default     = 10
}

variable "instance_disk_type" {
  type    = "string"
  default = "PD_SSD"
}

variable "instance_failover_members" {
  description = "number of failover instances to start"
  default     = 1
}

variable "instance_maintenance_timing" {
  type = "map"

  default = {
    earlier = "canary"
    later   = "stable"
  }
}

variable "instance_read_only_replica_count" {
  description = "number of read only replicas to create"
  default     = 0
}

variable "instance_region" {
  type = "string"
}

variable "instance_tier" {
  type    = "string"
  default = "db-n1-standard-2"
}

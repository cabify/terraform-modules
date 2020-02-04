variable "service_name" {
  description = "Name of the service - will be used for instance names"
  type        = "string"
}

variable "user_name" {
  description = "Username for the db (16 char max length)"
  type        = "string"
}

variable "user_password" {
  description = "Clear text password for db user"
  type        = "string"
}

variable "instance_region" {
  description = "Where to start the instances"
  type        = "string"
}

variable "project" {
  description = "Name of the gcp project"
  type        = "string"
}

variable "namespace" {
  description = "Namespace to use"
  type        = "string"
}

variable "owner" {
  description = "Name of team who owns the service"
  type        = "string"
}

variable "tier" {
  description = "Name of tier (1.2.3)"
  type        = "string"
}

variable "instance_read_only_replica_count" {
  description = "Number of read only replicas to create"
  default     = 0
}

variable "instance_tier" {
  description = "Tier to be passed on to prometheus"
  type        = "string"
}

variable "instance_tier_failover" {
  description = "Tier to be passed on to prometheus"
  type        = "string"
  default     = "UNSET"
}

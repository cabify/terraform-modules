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
  default     = "prometheus"
}

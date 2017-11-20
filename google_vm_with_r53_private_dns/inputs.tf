variable "gce_zone" {
  type    = "string"
  default = ""
}

variable "aws_route53_zone_id" {
  type    = "string"
  default = ""
}

variable "aws_route53_zone_name" {
  type    = "string"
  default = ""
}

variable "component" {
  type    = "string"
  default = "default_component"
}

variable "host_group" {
  type    = "string"
  default = "default_host_group"
}

variable "instance_count" {
  type    = "string"
  default = 0
}

variable "machine_type" {
  type    = "string"
  default = "n1-standard-1"
}

variable "os_image" {
  description = "OS GCE identifier"
  type        = "string"
  default     = "ubuntu-1404-lts"
}

variable "google_deployer_ssh_public_key" {
  type    = "string"
  default = ""
}

variable "service_account_scopes" {
  type    = "list"
  default = []
}

variable "service_account_email" {
  type    = "string"
  default = ""
}

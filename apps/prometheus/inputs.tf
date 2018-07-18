variable "gc_zone" {
  description = "Where to start the instances"
  type        = "string"
}

variable "gc_project" {
  description = "Name of the gcp project"
  type        = "string"
}

variable "namespace" {
  description = "Namespace to use"
  type        = "string"
  default     = "prometheus-scrapers"
}

variable "prometheus-port" {
  type    = "String"
  default = "9090"
}

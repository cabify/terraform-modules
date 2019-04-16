variable "service" {
  description = "Name of the service - will be used for instance names"
  type        = "string"
}

variable "args" {
  description = "List of args passed to the docker container - "
  type        = "list"
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

variable "image-name" {
  description = "Name for the stackdriver container image"
  type        = "string"
  default     = "frodenas/stackdriver-exporter"
}

variable "image-tag" {
  description = "Tag for the stackdriver container image"
  type        = "string"
  default     = "latest"
}

variable "prometheus-scrape-flag" {
  description = "Annotation for prometheus to scrape the service by"
  type        = "string"
  default     = "persistence"
}

variable "environment" {
  description = "Name of the environment"
  type        = "string"
}

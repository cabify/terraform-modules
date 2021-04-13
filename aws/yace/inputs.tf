variable "name" {
  description = "name to be used for the exporter"
  type        = string
}

variable "exporter_key" {
  description = "exporter AWS_ACCESS_KEY"
  type        = string
}

variable "exporter_secret" {
  description = "exporter AWS_SECRET_KEY"
  type        = string
}

variable "exporter_role_arn" {
  description = "exporter AWS_ROLE_ARN to assume"
  type        = string
}

variable "aws_account" {
  type = string
}

variable "aws_account_nr" {
  type = string
}

variable "region" {
  type = string
}

variable "owner" {
  type = string
}

variable "tier" {
  type = string
}

variable "namespace" {
  type = string
}

variable "prometheus-scrape-flag-exporter" {
  description = "Annotation for prometheus to scrape the exporter service by"
  type        = string
}

variable "exporter-data" {
  description = "data passed on to the yace exporter"
  type        = string
}

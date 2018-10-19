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
  default     = "prometheus"
}

variable "prometheus-port" {
  type    = "string"
  default = "9090"
}

variable "prometheus-storageclass" {
  type    = "string"
  default = "prometheus-ssd"
}

variable "scrape_tag" {
  description = "Scrape tag that prometheus will use"
  type        = "string"
  default     = "scrape_me"
}

variable "prometheus_config" {
  description = "Valid rendered prometheus.yaml config"
  type        = "string"
}

variable "scrape_tag" {
  description = "Scrape tag that prometheus will use"
  type        = "string"
  default     = "scrape_me"
}

variable "prometheus_config" {
  description = "Valid rendered prometheus.yaml config"
  type        = "string"
}

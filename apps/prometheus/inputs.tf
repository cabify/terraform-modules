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

variable "storage_size" {
  type    = "string"
  default = "120Gi"
}

variable "instance_type" {
  type    = "string"
  default = "n1-standard-1"
}

variable "prometheus_config" {
  description = "Valid rendered prometheus.yaml config"
  type        = "string"
}

variable "livenessprobe_delay" {
  description = "Liveness probe delay for prometheus kubernetes pod"
  type        = "string"
  default     = "30"
}

variable "external_url" {
  description = "External URL. Read about web.external-url in prometheus config"
  type        = "string"
}

variable "log_level" {
  description = "Log level for the instance. Defaults to info."
  type        = "string"
  default     = "warn"
}

variable "prometheus_io_scrape" {
  description = "Set it to your desired value to get prometheus scraped. By default it will be true"
  type        = "string"
  default     = "true"
}

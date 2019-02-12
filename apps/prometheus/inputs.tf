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

variable "prometheus_storageclass" {
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

variable "prometheus_memory_limit" {
  description = "Memory limit for the kubernetes prometheus pod"
  type        = "string"
  default     = "6Gi"
}

variable "prometheus_memory_request" {
  description = "Memory request (minimum) for the kubernetes prometheus pod"
  type        = "string"
  default     = "3Gi"
}

variable "prometheus_cpu_limit" {
  description = "CPU limit for the prometheus kubernetes pod"
  type        = "string"
  default     = "2"
}

variable "prometheus_cpu_request" {
  description = "CPU request for the prometheus kubernetes pod"
  type        = "string"
  default     = "1"
}

variable "livenessprobe_delay" {
  description = "Liveness probe delay for prometheus kubernetes pod"
  type        = "string"
  default     = "30"
}

variable "livenessprobe_timeout_seconds" {
  description = "Number of seconds after which the probe times out"
  type        = "string"
  default     = "5"
}

variable "livenessprobe_period_seconds" {
  description = "Interval of seconds that the probe will use"
  type        = "string"
  default     = "3"
}

variable "readinessprobe_timeout_seconds" {
  description = "Number of seconds after which the probe times out"
  type        = "string"
  default     = "5"
}

variable "readinessprobe_period_seconds" {
  description = "Interval of seconds that the probe will use"
  type        = "string"
  default     = "5"
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

################################################################################
## Trickster
################################################################################

variable "trickster_port" {
  description = "Port where trickster is going to listen. We're using the 9092 to avoid collisions with prometheus port. This port is unallocated by the community to avoid conflicts with kafka but we're not going to have this problem inside our replication controller."
  type        = "string"
  default     = "9092"
}

variable "trickster_metrics_port" {
  description = "Port where trickster exposes its metrics."
  type        = "string"
  default     = "8082"
}

variable "trickster_config" {
  description = "Valid rendered trickster.yaml config"
  type        = "string"
}

variable "trickster_memory_limit" {
  description = "Memory limit for the kubernetes trickster pod"
  type        = "string"
  default     = "6Gi"
}

variable "trickster_memory_request" {
  description = "Memory request (minimum) for the kubernetes trickster pod"
  type        = "string"
  default     = "1Gi"
}

variable "trickster_cpu_limit" {
  description = "CPU limit for the trickster kubernetes pod"
  type        = "string"
  default     = "2"
}

variable "trickster_cpu_request" {
  description = "CPU request for the trickster kubernetes pod"
  type        = "string"
  default     = "1"
}

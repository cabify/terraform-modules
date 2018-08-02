variable "username" {
  description = "Username for ealsticsearch"
  type        = "string"
  default     = "admin"
}

variable "password" {
  description = "Password for ealsticsearch"
  type        = "string"
  default     = "pass"
}

variable "url" {
  description = "Url for ealsticsearch"
  type        = "string"
  default     = "localhost"
}

variable "port" {
  description = "Port for ealsticsearch"
  type        = "string"
  default     = "9200"
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

variable "container_port" {
  description = "Port the container will use"
  type        = "string"
  default     = "9108"
}

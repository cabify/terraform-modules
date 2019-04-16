variable "service" {
  description = "Name of service"
  type        = "string"
}

variable "password" {
  description = "Password for redis"
  type        = "string"
  default     = ""
}

variable "url" {
  description = "Url for redis"
  type        = "string"
  default     = "localhost"
}

variable "port" {
  description = "Port for redis"
  type        = "string"
  default     = "6379"
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

variable "owner" {
  description = "Name of team who owns the service"
  type        = "string"
}

variable "tier" {
  description = "Name of tier (1.2.3)"
  type        = "string"
}

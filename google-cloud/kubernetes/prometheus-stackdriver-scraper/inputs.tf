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

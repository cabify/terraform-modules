variable "name" {
  type        = "string"
  description = "Name of the service"
}

variable "namespace" {
  type        = "string"
  description = "Name of the service"
}

variable "port" {
  type        = "string"
  description = "Port of the service"
}

variable "ipaddress" {
  type        = "string"
  description = "Ipaddress of the service"
}

variable "https" {
  type        = "string"
  description = "Is this service scraped via https?"
  default     = "false"
}

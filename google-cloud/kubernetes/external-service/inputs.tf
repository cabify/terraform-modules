variable "name" {
  type        = string
  description = "Name of the service"
}

variable "namespace" {
  type        = string
  description = "Name of the service"
}

variable "port" {
  type        = string
  description = "Port of the service"
}

variable "https" {
  type        = string
  description = "Is this service scraped via https?"
  default     = "false"
}

variable "fqdn" {
  type        = string
  description = "FQDN for external service to scrape"
  default     = ""
}

###############################################################################
# Variables without default value
###############################################################################
variable "gcp_image" {
  description = "Which image should be used for the VMs."
  type        = "string"
}

variable "service_name" {
  description = "Name of the service to which the cluster will serve."
  type        = "string"
}

variable "first_instance_size" {
  description = "Machine type of the first instance."
  type        = "string"
}

variable "replica_instance_size" {
  description = "Machine type of the other instances"
  type        = "string"
}

variable "network" {
  description = "Network to be used for the cluster"
  type        = "string"
}

variable "subnetwork" {
  description = "Subnetwork to be used for the instances"
  type        = "string"
}

variable "user_name" {
  description = "Username for the db (16 char max length)"
  type        = "string"
}

variable "user_password" {
  description = "Clear text password for db user"
  type        = "string"
}

variable "zone_first" {
  description = "GCP Zone in which the instance 1 should be created."
  type        = "string"
}

variable "zone_second" {
  description = "GCP Zone in which the instance 2 should be created."
  type        = "string"
}

variable "zone_third" {
  description = "GCP Zone in which the instance 3 should be created."
  type        = "string"
}

###############################################################################
# Variables with default value
###############################################################################
variable "deletion_protection" {
  description = "Bool if the instance deletetion_protection is enabled or not."
  type        = "string"
  default     = false
}

variable "disk_size" {
  description = "Instances disk size (GB)."
  default     = 100
}

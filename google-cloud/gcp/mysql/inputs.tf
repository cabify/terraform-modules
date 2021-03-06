###############################################################################
# Variables without default value
###############################################################################
variable "gcp_image" {
  description = "Which image should be used for the VMs."
  type        = string
}

variable "service_name" {
  description = "Name of the service to which the cluster will serve."
  type        = string
}

variable "first_instance_size" {
  description = "Machine type of the first instance."
  type        = string
}

variable "replica_instance_size" {
  description = "Machine type of the other instances"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork to be used for the instances"
  type        = string
}

variable "user_name" {
  description = "Username for the db (16 char max length)"
  type        = string
}

variable "user_password" {
  description = "Clear text password for db user"
  type        = string
}

variable "zone_1" {
  description = "GCP Zone in which the instance 1 should be created."
  type        = string
}

variable "zone_2" {
  description = "GCP Zone in which the instance 2 should be created."
  type        = string
}

variable "zone_3" {
  description = "GCP Zone in which the instance 3 should be created."
  type        = string
}

###############################################################################
# Variables with default value
###############################################################################
variable "deletion_protection" {
  description = "Bool if the instance deletetion_protection is enabled or not."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Instances disk size (GB)."
  type        = number
  default     = 100
}

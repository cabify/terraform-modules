variable "letsencrypt_email" {
  type = string
}

variable "letsencrypt_prod_issuer_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "letsencrypt_staging_issuer_name" {
  type    = string
  default = "letsencrypt-staging"
}

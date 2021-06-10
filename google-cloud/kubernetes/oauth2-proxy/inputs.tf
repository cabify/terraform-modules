###############################################################################
## Oauth2 Proxy Configuration
###############################################################################
variable "oauth2_proxy_client_id" {
  type = string
}

variable "oauth2_proxy_client_secret" {
  type = string
}

variable "oauth2_proxy_cookie" {
  type = string
}

###############################################################################
## Oauth2 Proxy Deployment
###############################################################################

variable "oauth2_proxy_deployment_namespace" {
  type    = string
  default = "ingress-nginx"
}

variable "oauth2_proxy_deployment_replicas" {
  type    = string
  default = "1"
}

variable "oauth2_proxy_deployment_image" {
  type = string
}

variable "oauth2_proxy_deployment_email_domain" {
  type = string
}

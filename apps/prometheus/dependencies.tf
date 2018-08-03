# This module will set up Nginx Ingress Controller in our cluster
module "set_up_ingress_nginx_controller" {
  source = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/ingress-nginx?ref=google-cloud_k8s_ingress-nginx-v0.1.0"
}

# This module will set up Oauth2 Proxy. It will run by default in the
# ingress-nginx namespace with replica 1. Read module documentation for more
# information
module "set_up_oauth2_proxy" {
  source                               = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/oauth2-proxy?ref=google-cloud_k8s_oauth2-proxy-v0.1.0"
  oauth2_proxy_client_id               = "123954151243-ui13i1fkha50al5em690c5n63gk9vtjn.apps.googleusercontent.com"
  oauth2_proxy_client_secret           = "joMiukzgduReWQWlKLxmXngc"
  oauth2_proxy_cookie                  = "y7KE_oD3AZl0Pz4Uo9kEjA=="
  oauth2_proxy_deployment_image        = "bcawthra/oauth2_proxy:latest"
  oauth2_proxy_deployment_email_domain = "cabify.com"
  oauth2_proxy_deployment_namespace    = "${var.namespace}"
}

# This module will set up Cert manager.
module "set_up_cert_manager" {
  source            = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/cert-manager?ref=google-cloud_k8s_cert-manager-v0.1.0"
  letsencrypt_email = "systems+letsencrypt@cabify.com"
}

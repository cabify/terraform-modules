# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Ingress.
# Here we will make use of a kubernetes manifest of kind Ingress.
# The tradeoffs of using this provider are that terraform outputs will be
# useless since you won't know what is changing from the current version, only
# that there are some changes.

# Second we will create an ingress for prometheus's oauth request that will target
# the oauth2_proxy service deployed in the dependencies.tf file.
data "template_file" "prometheus-oauth2-proxy-ingress" {
  template = "${file("${path.module}/prometheus-oauth2-proxy-ingress.yaml")}"

  vars {
    hostname  = "${var.hostname}"
    namespace = "${var.namespace}"
  }
}

resource "k8s_manifest" "prometheus-oauth2-proxy-ingress" {
  content = "${data.template_file.prometheus-oauth2-proxy-ingress.rendered}"
}

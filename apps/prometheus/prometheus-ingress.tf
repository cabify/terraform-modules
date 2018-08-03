# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Ingress.
# Here we will make use of a kubernetes manifest of kind Ingress.
# The tradeoffs of using this provider are that terraform outputs will be
# useless since you won't know what is changing from the current version, only
# that there are some changes.

# First we will create an ingress for prometheus. This ingress will redirect
# requests to the prometheus service.
data "template_file" "prometheus-ingress" {
  template = "${file("${path.module}/prometheus-ingress.yaml")}"

  vars {
    common-hostname = "${replace(var.hostname, ".", "-")}"
    hostname        = "${var.hostname}"
    namespace       = "${var.namespace}"
    servicename     = "${kubernetes_service.prometheus.metadata.0.name}"
    serviceport     = "${var.prometheus-port}"
  }
}

resource "k8s_manifest" "prometheus-ingress" {
  content    = "${data.template_file.prometheus-ingress.rendered}"
  depends_on = ["kubernetes_service.prometheus"]
}

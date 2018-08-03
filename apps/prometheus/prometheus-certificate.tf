# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Kubernetes Certificates 
# We will be issuing a certificate against the letsencrypt-prod certificate
# issuer.
data "template_file" "prometheus_certificate" {
  template = "${file("${path.module}/prometheus-certificate.yaml")}"

  vars {
    common-hostname = "${replace(var.hostname, ".", "-")}"
    hostname        = "${var.hostname}"
    namespace       = "${var.namespace}"
  }
}

resource "k8s_manifest" "prometheus_certificate" {
  content = "${data.template_file.prometheus_certificate.rendered}"
}

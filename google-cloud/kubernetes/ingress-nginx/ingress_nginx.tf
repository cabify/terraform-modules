# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Ingress.
# Here we will make use of a kubernetes manifest of kind Ingress.
# The tradeoffs of using this provider are that terraform outputs will be
# useless since you won't know what is changing from the current version, only
# that there are some changes.

data "template_file" "ingress_nginx" {
  template = file("${path.module}/ingress_nginx_template.yaml")

  vars = {
    static_ip = google_compute_address.ingress_nginx_static_ip.address
  }
}

resource "k8s_manifest" "ingress_nginx" {
  content = data.template_file.ingress_nginx.rendered
}

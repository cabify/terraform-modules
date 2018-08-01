# Runs the mandatory manifests https://kubernetes.github.io/ingress-nginx/deploy/#mandatory-command
data "template_file" "ingress_nginx_mandatory_template" {
  template = "${file("mandatory.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory" {
  content = "${data.template_file.ingress_nginx_mandatory_template.rendered}"
}

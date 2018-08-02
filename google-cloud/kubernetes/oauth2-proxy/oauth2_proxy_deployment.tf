data "template_file" "oauth2_proxy_deployment" {
  template = "${file("${path.module}/oauth2_proxy_deployment.yaml")}"

  vars {
    namespace    = "${var.oauth2_proxy_deployment_namespace}"
    replicas     = "${var.oauth2_proxy_deployment_replicas}"
    image        = "${var.oauth2_proxy_deployment_image}"
    email_domain = "${var.oauth2_proxy_deployment_email_domain}"
  }
}

resource "k8s_manifest" "oauth2_proxy_deployment" {
  content = "${data.template_file.oauth2_proxy_deployment.rendered}"
}

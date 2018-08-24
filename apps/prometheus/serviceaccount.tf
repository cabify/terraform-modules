resource "kubernetes_service_account" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }
}

data "template_file" "clusterrole" {
  template = "${file("${path.module}/files/clusterrole.yaml")}"
}

resource "k8s_manifest" "clusterrole" {
  content    = "${data.template_file.clusterrole.rendered}"
  depends_on = ["kubernetes_service_account.prometheus"]
}

data "template_file" "clusterrolebinding" {
  template = "${file("${path.module}/files/clusterrolebinding.yaml")}"
}

resource "k8s_manifest" "clusterrolebinding" {
  content    = "${data.template_file.clusterrolebinding.rendered}"
  depends_on = ["kubernetes_service_account.prometheus"]
}

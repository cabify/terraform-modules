resource "kubernetes_namespace" "prometheus" {
  metadata {
    annotations {
      type = "${var.namespace}"
    }

    name = "${var.namespace}"
  }
}

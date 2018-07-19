resource "kubernetes_namespace" "prometheus" {
  metadata {
    annotations {
      type = "prometheus"
    }

    name = "prometheus"
  }
}

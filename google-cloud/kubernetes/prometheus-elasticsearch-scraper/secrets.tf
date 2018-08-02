resource "kubernetes_secret" "elasticsearch" {
  metadata {
    name      = "elasticsearch-credentials"
    namespace = "${var.namespace}"
  }

  data {
    uri = "https://${var.username}:${var.password}@${var.url}:${var.port}"
  }
}

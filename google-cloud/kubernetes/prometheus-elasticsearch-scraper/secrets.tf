resource "kubernetes_secret" "elasticsearch" {
  metadata {
    name      = "${replace(var.project, "cabify-", "")}-elasticsearch-credentials"
    namespace = var.namespace
  }

  data = {
    uri = "https://${var.username}:${var.password}@${var.url}:${var.port}"
  }
}


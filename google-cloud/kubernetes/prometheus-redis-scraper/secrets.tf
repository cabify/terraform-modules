resource "kubernetes_secret" "redis" {
  metadata {
    name      = "${var.service}-${replace(var.project, "cabify-", "")}-redis-credentials"
    namespace = var.namespace
  }

  data = {
    password = var.password
  }
}


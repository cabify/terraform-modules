resource "kubernetes_secret" "redis" {
  metadata {
    name      = "${var.service}-redis-credentials"
    namespace = "${var.namespace}"
  }

  data {
    password = "${var.password}"
  }
}

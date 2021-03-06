//We need this until https://github.com/terraform-providers/terraform-provider-kubernetes/pull/101 can be merged

resource "kubernetes_replication_controller" "redis" {
  metadata {
    name = "${var.service}-${replace(var.project, "cabify-", "")}-redis-scraper"

    labels = {
      app = "${var.service}-${replace(var.project, "cabify-", "")}-redis-scraper"
    }

    namespace = var.namespace
  }

  spec {
    selector = {
      app = "${var.service}-${replace(var.project, "cabify-", "")}-redis-scraper"
    }

    template {
      metadata {
        labels = {
          app = "${var.service}-${replace(var.project, "cabify-", "")}-redis-scraper"
        }
        annotations = {}
      }
      spec {
        automount_service_account_token = false
        enable_service_links            = false

        container {
          resources {
            limits = {
              cpu    = "250m"
              memory = "50Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "25Mi"
            }
          }

          image = "oliver006/redis_exporter"
          name  = "redis-exporter"

          port {
            container_port = var.container_port
          }

          env {
            name = "REDIS_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.redis.metadata[0].name
                key  = "password"
              }
            }
          }

          env {
            name  = "REDIS_ADDR"
            value = "${var.url}:${var.port}"
          }

          args = ["--web.listen-address", "0.0.0.0:${var.container_port}"]

          liveness_probe {
            http_get {
              path = "/"
              port = var.container_port
            }

            initial_delay_seconds = 5
            period_seconds        = 3
          }
        }
      }
    }
  }
}


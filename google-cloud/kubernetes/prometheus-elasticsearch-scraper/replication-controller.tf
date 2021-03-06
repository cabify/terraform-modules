//We need this until https://github.com/terraform-providers/terraform-provider-kubernetes/pull/101 can be merged

resource "kubernetes_replication_controller" "elasticsearch" {
  metadata {
    name = "${replace(var.project, "cabify-", "")}-elasticsearch-scraper"

    labels = {
      app = "${replace(var.project, "cabify-", "")}-elasticsearch-scraper"
    }

    namespace = var.namespace
  }

  spec {
    selector = {
      app = "${replace(var.project, "cabify-", "")}-elasticsearch-scraper"
    }

    template {
      metadata {
        labels = {
          app = "${replace(var.project, "cabify-", "")}-elasticsearch-scraper"
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

          image = "justwatch/elasticsearch_exporter:1.1.0"
          name  = "${replace(var.project, "cabify-", "")}-elasticsearch-exporter"

          port {
            container_port = var.container_port
          }

          env {
            name = "ES_URI"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.elasticsearch.metadata[0].name
                key  = "uri"
              }
            }
          }

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

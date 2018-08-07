//We need this until https://github.com/terraform-providers/terraform-provider-kubernetes/pull/101 can be merged

resource "kubernetes_replication_controller" "elasticsearch" {
  metadata {
    name = "elasticsearch-scraper"

    labels {
      app = "elasticsearch-scraper"
    }

    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "elasticsearch-scraper"
    }

    template {
      restart_policy = "Always"

      container {
        image = "justwatch/elasticsearch_exporter"
        name  = "elasticsearch-exporter"

        port {
          container_port = "${var.container_port}"
        }

        env {
          name = "URI"

          value_from {
            secret_key_ref {
              name = "${kubernetes_secret.elasticsearch.metadata.0.name}"
              key  = "uri"
            }
          }
        }

        args = ["-es.uri=$URI"]

        liveness_probe {
          http_get {
            path = "/"
            port = "${var.container_port}"
          }

          initial_delay_seconds = 5
          period_seconds        = 3
        }
      }
    }
  }
}

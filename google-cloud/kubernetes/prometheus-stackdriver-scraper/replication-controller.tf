//We need this until https://github.com/terraform-providers/terraform-provider-kubernetes/pull/101 can be merged

resource "kubernetes_replication_controller" "kubernetes_replication_controller-stackdriver-scraper-module" {
  metadata {
    name = "${var.service}-stackdriver-scraper"

    labels {
      app = "${var.service}-stackdriver-scraper"
    }

    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${var.service}-stackdriver-scraper"
    }

    template {
      restart_policy = "Always"

      node_selector {
        "cloud.google.com/gke-nodepool" = "gke-prometheus-scrapers"
      }

      volume {
        name = "secret-volume"

        secret {
          secret_name = "${kubernetes_secret.kubernetes_secret_module.metadata.0.name}"
        }
      }

      container {
        image = "frodenas/stackdriver-exporter"
        name  = "${var.service}-stackdriver-exporter"

        port {
          container_port = 9255
        }

        volume_mount {
          name       = "secret-volume"
          mount_path = "/etc/secret-volume"
        }

        env {
          name  = "GOOGLE_APPLICATION_CREDENTIALS"
          value = "/etc/secret-volume/gcloud-service-account-key"
        }

        args = "${var.args}"

        liveness_probe {
          http_get {
            path = "/"
            port = 9255
          }

          initial_delay_seconds = 5
          period_seconds        = 3
        }
      }
    }
  }
}
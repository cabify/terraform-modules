//We need this until https://github.com/terraform-providers/terraform-provider-kubernetes/pull/101 can be merged

resource "kubernetes_deployment" "stackdriver" {
  metadata {
    name = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-scraper"

    labels = {
      app = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-scraper"
    }

    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        app = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-scraper"
      }
    }

    template {
      metadata {
        name = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-scraper"

        labels = {
          app = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-scraper"
        }
      }
      spec {
        restart_policy                  = "Always"
        automount_service_account_token = false
        enable_service_links            = false

        volume {
          name = "secret-volume"

          secret {
            secret_name = kubernetes_secret.stackdriver.metadata[0].name
          }
        }

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

          image = "${var.image-name}:${var.image-tag}"
          name  = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-exporter"

          port {
            container_port = 9255
          }

          volume_mount {
            name       = "secret-volume"
            mount_path = "/etc/secret-volume"
          }

          env {
            name  = "GOOGLE_APPLICATION_CREDENTIALS"
            value = "/etc/secret-volume/credentials.json"
          }

          env {
            name  = "STACKDRIVER_EXPORTER_GOOGLE_PROJECT_ID"
            value = var.project
          }

          args = var.args

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
}


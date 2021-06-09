resource "kubernetes_deployment" "exporter" {
  wait_for_rollout = true
  metadata {
    name = "${replace(var.aws_account, "cabify-", "")}-${var.name}-exporter"

    labels = {
      app = format("%.50s", md5("${var.aws_account}-${var.name}-exporter"))
    }

    namespace = var.namespace
  }

  spec {

    selector {
      match_labels = {
        app = format("%.50s", md5("${var.aws_account}-${var.name}-exporter"))
      }
    }

    template {
      metadata {
        name = "${replace(var.aws_account, "cabify-", "")}-${var.name}-exporter"

        labels = {
          app = format("%.50s", md5("${var.aws_account}-${var.name}-exporter"))
        }
      }
      spec {
        restart_policy = "Always"

        container {
          resources {
            limits = {
              cpu    = "250m"
              memory = "64Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "48Mi"
            }
          }

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/yet-another-cloudwatch-exporter/yet-another-cloudwatch-exporter"
          name  = "yet-another-cloudwatch-exporter"

          port {
            container_port = 5000
          }

          env {
            name  = "${upper(var.name)}_METRICS"
            value = var.exporter-data
          }

          env {
            name  = "${upper(var.name)}_DELAY"
            value = var.exporter-delay
          }

          env {
            name  = "REGION"
            value = var.region
          }

          env {
            name = "AWS_ACCESS_KEY_ID"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.exporter.metadata[0].name
                key  = "aws_access_key"
              }
            }
          }

          env {
            name = "AWS_SECRET_ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.exporter.metadata[0].name
                key  = "aws_secret_key"
              }
            }
          }

          env {
            name = "ROLE_ARN"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.exporter.metadata[0].name
                key  = "aws_role_arn"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 5000
            }

            initial_delay_seconds = 5
            period_seconds        = 60
          }
        }
      }
    }
  }
}

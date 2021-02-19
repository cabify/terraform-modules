resource "kubernetes_deployment" "cloudwatch" {
  wait_for_rollout = true
  metadata {
    name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-cloudwatch"

    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cloudwatch"))
    }

    namespace = var.namespace
  }

  spec {

    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cloudwatch"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-cloudwatch"

        labels = {
          app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cloudwatch"))
        }
      }
      spec {
        restart_policy = "Always"

        container {
          resources {
            limits {
              cpu    = "250m"
              memory = "50Mi"
            }

            requests {
              cpu    = "100m"
              memory = "25Mi"
            }
          }

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/rds-cloudwatch-exporter/rds-cloudwatch-exporter"
          name  = "cloudwatch-exporter"

          port {
            container_port = 9042
          }

          env {
            name  = "INSTANCE"
            value = var.instance_name
          }

          env {
            name  = "OWNER"
            value = var.owner
          }

          env {
            name  = "REGION"
            value = var.region
          }

          env {
            name  = "SERVICE"
            value = var.service_name == "UNSET" ? var.instance_name : var.service_name
          }

          env {
            name  = "TIER"
            value = var.tier
          }

          env {
            name = "ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter"
                key  = "aws_access_key"
              }
            }
          }

          env {
            name = "SECRET_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter"
                key  = "aws_secret_key"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/basic"
              port = 9042
            }

            initial_delay_seconds = 5
            period_seconds        = 60
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "cloudwatch-read-only" {
  count            = var.read_only_replicas
  wait_for_rollout = true

  metadata {
    name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-cloudwatch"

    labels = {
      app = format(
        "%.60s",
        md5(
          "${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cloudwatch",
        ),
      )
    }

    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cloudwatch"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-cloudwatch"

        labels = {
          app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cloudwatch"))
        }
      }

      spec {
        restart_policy = "Always"

        container {
          resources {
            limits {
              cpu    = "250m"
              memory = "50Mi"
            }

            requests {
              cpu    = "100m"
              memory = "25Mi"
            }
          }

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/rds-cloudwatch-exporter/rds-cloudwatch-exporter"
          name  = "cloudwatch-exporter"

          port {
            container_port = 9042
          }

          env {
            name  = "INSTANCE"
            value = "${var.instance_name}-read-replica-${count.index + 1}"
          }

          env {
            name  = "OWNER"
            value = var.owner
          }

          env {
            name  = "REGION"
            value = var.region
          }

          env {
            name  = "SERVICE"
            value = var.service_name == "UNSET" ? var.instance_name : var.service_name
          }

          env {
            name  = "TIER"
            value = var.tier
          }


          env {
            name = "ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter"
                key  = "aws_access_key"
              }
            }
          }

          env {
            name = "SECRET_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter"
                key  = "aws_secret_key"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 9042
            }

            initial_delay_seconds = 5
            period_seconds        = 3
          }
        }
      }
    }
  }
}

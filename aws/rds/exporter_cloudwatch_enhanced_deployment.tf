# Only difference with "cloudwatch" is on how we start the metrics containers

resource "kubernetes_deployment" "cloudwatch-enhanced" {
  count = var.cloudwatch_enhanced_enabled ? 1 : 0
  wait_for_rollout = true
  metadata {
    name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-cw-e"

    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cw-e"))
    }

    namespace = var.namespace
  }

  spec {

    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cw-e"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-cw-e"

        labels = {
          app = format("%.60s", md5("${var.instance_name}${var.aws_account}-cw-e"))
        }
      }
      spec {
        restart_policy = "Always"

        container {
          resources {
            limits {
              cpu    = "250m"
              memory = "64Mi"
            }

            requests {
              cpu    = "100m"
              memory = "48Mi"
            }
          }

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/rds-cloudwatch-exporter/rds-cloudwatch-exporter"
          name  = "cloudwatch-exporter"

          port {
            container_port = 9042
          }

          env {
            name  = "DISABLE_BASIC"
            value = "true"
          }

          env {
            name  = "OWNER"
            value = var.owner
          }

          env {
            name  = "TIER"
            value = var.tier
          }

          env {
            name  = "INSTANCE"
            value = var.instance_name
          }

          env {
            name  = "REGION"
            value = var.region
          }

          env {
            name = "ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_access_key"
              }
            }
          }

          env {
            name = "SECRET_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_secret_key"
              }
            }
          }

          env {
            name = "ROLE_ARN"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_role_arn"
              }
            }
          }

          liveness_probe {
            http_get {
              path = var.rds_exporter_health_path
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

resource "kubernetes_deployment" "cloudwatch-read-only-enhanced" {
  count = var.cloudwatch_enhanced_enabled ? var.read_only_replicas : 0
  wait_for_rollout = true

  metadata {
    name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-cw-e"

    labels = {
      app = format(
        "%.60s",
        md5(
          "${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cw-e",
        ),
      )
    }

    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cw-e"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-cw-e"

        labels = {
          app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}-cw-e"))
        }
      }

      spec {
        restart_policy = "Always"

        container {
          resources {
            limits {
              cpu    = "250m"
              memory = "64Mi"
            }

            requests {
              cpu    = "100m"
              memory = "48Mi"
            }
          }

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/rds-cloudwatch-exporter/rds-cloudwatch-exporter"
          name  = "cloudwatch-exporter"

          port {
            container_port = 9042
          }

          env {
            name  = "DISABLE_BASIC"
            value = "true"
          }

          env {
            name  = "OWNER"
            value = var.owner
          }

          env {
            name  = "TIER"
            value = var.tier
          }

          env {
            name  = "INSTANCE"
            value = "${var.instance_name}-read-replica-${count.index + 1}"
          }

          env {
            name  = "REGION"
            value = var.region
          }

          env {
            name = "ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_access_key"
              }
            }
          }

          env {
            name = "SECRET_KEY"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_secret_key"
              }
            }
          }

          env {
            name = "ROLE_ARN"

            value_from {
              secret_key_ref {
                name = "rds-exporter-tf"
                key  = "aws_role_arn"
              }
            }
          }

          liveness_probe {
            http_get {
              path = var.rds_exporter_health_path
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

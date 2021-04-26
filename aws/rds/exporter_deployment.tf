resource "kubernetes_deployment" "rds" {
  wait_for_rollout = true
  metadata {
    name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-mysql-scraper"

    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}"))
    }

    namespace = var.namespace
  }

  spec {

    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}${var.aws_account}"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-mysql-rds-exporter"

        labels = {
          app = format("%.60s", md5("${var.instance_name}${var.aws_account}"))
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

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/mysqld-exporter-rds-ssl/mysqld-exporter-rds-ssl"
          name  = "exporter"

          port {
            container_port = 9104
          }

          env {
            name = "EXPORTER_USERNAME"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.rds.metadata[0].name
                key  = "exporter_username"
              }
            }
          }

          env {
            name = "EXPORTER_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.rds.metadata[0].name
                key  = "exporter_password"
              }
            }
          }

          env {
            name  = "EXPORTER_HOSTNAME"
            value = aws_db_instance.primary.address
          }

          args = concat(var.exporter_collector_flags, aws_db_instance.primary.performance_insights_enabled ? var.exporter_collector_perf_flags : [])

          liveness_probe {
            http_get {
              path = "/"
              port = 9104
            }

            initial_delay_seconds = 5
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "rds-read-only" {
  count            = var.read_only_replicas
  wait_for_rollout = true

  metadata {
    name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-mysql-rds-exporter"

    labels = {
      app = format(
        "%.60s",
        md5(
          "${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}",
        ),
      )
    }

    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-read-replica-${count.index + 1}-${replace(var.aws_account, "cabify-", "")}-mysql-rds-scraper"

        labels = {
          app = format("%.60s", md5("${var.instance_name}-read-replica-${count.index + 1}-${var.aws_account}"))
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

          image = "us.gcr.io/cabify-controlpanel/infrastructure/persistence/dockerfiles/mysqld-exporter-rds-ssl/mysqld-exporter-rds-ssl"
          name  = "exporter"

          port {
            container_port = 9104
          }

          env {
            name = "EXPORTER_USERNAME"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.rds.metadata[0].name
                key  = "exporter_username"
              }
            }
          }

          env {
            name = "EXPORTER_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.rds.metadata[0].name
                key  = "exporter_password"
              }
            }
          }

          env {
            name  = "EXPORTER_HOSTNAME"
            value = aws_db_instance.read-replica[count.index].address

          }

          args = concat(var.exporter_collector_flags, aws_db_instance.primary.performance_insights_enabled ? var.exporter_collector_perf_flags : [])

          liveness_probe {
            http_get {
              path = "/"
              port = 9104
            }

            initial_delay_seconds = 5
            period_seconds        = 3
          }
        }
      }
    }
  }
}

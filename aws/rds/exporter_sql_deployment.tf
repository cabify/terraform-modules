resource "kubernetes_deployment" "sql_exporter" {
  count            = var.sql_exporter_enabled ? 1 : 0
  wait_for_rollout = true
  metadata {
    name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-sql-exporter"

    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
    }

    namespace = var.namespace
  }

  spec {

    selector {
      match_labels = {
        app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
      }
    }

    template {
      metadata {
        name = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-sql-exporter"

        labels = {
          app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
        }
      }
      spec {
        restart_policy                  = "Always"
        automount_service_account_token = false
        enable_service_links            = true

        container {
          resources {
            limits = {
              cpu    = "150m"
              memory = "50Mi"
            }

            requests = {
              cpu    = "150m"
              memory = "50Mi"
            }
          }

          image = "githubfree/sql_exporter"
          name  = "sql-exporter"

          args = [
            "-config.file=/etc/sql-exporter/config.yml"
          ]

          port {
            container_port = 9399
          }

          volume_mount {
            name       = "sql-exporter-querries"
            mount_path = "/etc/sql-exporter-querries/"
          }

          volume_mount {
            name              = "sql-exporter-config"
            mount_path        = "/etc/sql-exporter/"
            mount_propagation = "None"
          }

          liveness_probe {
            http_get {
              path = "/status"
              port = 9399
            }

            initial_delay_seconds = 5
            period_seconds        = 60
          }
        }

        volume {
          name = "sql-exporter-querries"
          config_map {
            default_mode = "0420"
            optional     = false
            name         = kubernetes_config_map.sql_exporter_querries.metadata.0.name
          }
        }

        volume {
          name = "sql-exporter-config"
          secret {
            default_mode = "0420"
            optional     = false
            secret_name  = kubernetes_secret.sql_exporter_config.metadata.0.name
          }
        }
      }
    }
  }
}

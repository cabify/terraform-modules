resource "kubernetes_replication_controller" "prometheus" {
  metadata {
    name = "prometheus-server"

    labels {
      app = "prometheus-server"
    }

    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  spec {
    selector {
      app = "prometheus-server"
    }

    template {
      restart_policy       = "Always"
      service_account_name = "prometheus"

      // "nobody" from prometheus Dockerfile
      security_context {
        fs_group    = 65534
        run_as_user = 65534
      }

      volume {
        name = "service-account-volume"

        secret {
          secret_name  = "${kubernetes_service_account.prometheus.default_secret_name}"
          default_mode = 420
        }
      }

      volume {
        name = "prometheus-config-volume"

        config_map {
          name         = "${kubernetes_config_map.prometheus-config-map.metadata.0.name}"
          default_mode = 420
        }
      }

      volume {
        name = "prometheus-storage-volume"

        persistent_volume_claim {
          claim_name = "${kubernetes_persistent_volume_claim.prometheus-server-data.metadata.0.name}"
        }
      }

      container {
        image = "prom/prometheus:v2.2.1"
        name  = "prometheus"

        port {
          container_port = "${var.prometheus-port}"
        }

        volume_mount {
          name       = "service-account-volume"
          mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
        }

        volume_mount {
          name       = "prometheus-config-volume"
          mount_path = "/etc/prometheus/"
        }

        volume_mount {
          name       = "prometheus-storage-volume"
          mount_path = "/prometheus/"
        }

        args = ["--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus/"]

        liveness_probe {
          http_get {
            path = "/"
            port = "${var.prometheus-port}"
          }

          initial_delay_seconds = 5
          period_seconds        = 3
        }
      }
    }
  }
}

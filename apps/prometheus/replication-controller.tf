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
      service_account_name = "${kubernetes_namespace.prometheus.metadata.0.name}"

      node_selector {
        "beta.kubernetes.io/instance-type" = "${var.instance_type}"
      }

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
          name         = "${kubernetes_config_map.prometheus.metadata.0.name}"
          default_mode = 420
        }
      }

      volume {
        name = "prometheus-alertrules-volume"

        config_map {
          name         = "alertrules"
          default_mode = 420
        }
      }

      volume {
        name = "prometheus-recordingrules-volume"

        config_map {
          name         = "recordingrules"
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
        image = "weaveworks/watch:master-5b2a6e5"
        name  = "config-watcher"

        volume_mount {
          name       = "prometheus-config-volume"
          mount_path = "/etc/prometheus/config/"
        }

        volume_mount {
          name       = "prometheus-alertrules-volume"
          mount_path = "/etc/prometheus/alerts/"
        }

        volume_mount {
          name       = "prometheus-recordingrules-volume"
          mount_path = "/etc/prometheus/recordings/"
        }

        args = ["-v", "-t", "-p=/etc/prometheus", "curl", "-X", "POST", "--fail", "-o", "-", "-sS", "http://localhost:${var.prometheus-port}/-/reload"]
      }

      container {
        image = "prom/prometheus:v2.5.0"
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
          mount_path = "/etc/prometheus/config/"
        }

        volume_mount {
          name       = "prometheus-alertrules-volume"
          mount_path = "/etc/prometheus/alerts/"
        }

        volume_mount {
          name       = "prometheus-recordingrules-volume"
          mount_path = "/etc/prometheus/recordings/"
        }

        volume_mount {
          name       = "prometheus-storage-volume"
          mount_path = "/prometheus/"
        }

        args = [
          "--config.file=/etc/prometheus/config/prometheus.yml",
          "--storage.tsdb.path=/prometheus/",
          "--web.enable-lifecycle",
          "--web.external-url=${var.external_url}",
          "--log.level=${var.log_level}"
        ]

        liveness_probe {
          http_get {
            path = "/"
            port = "${var.prometheus-port}"
          }

          initial_delay_seconds = "${var.livenessprobe_delay}"
          period_seconds        = 3
        }
      }
    }
  }
}

resource "kubernetes_replication_controller" "cloudsql" {
  metadata {
    name = "${var.service_name}-${replace(replace(var.project, "cabify-", ""), "-cloudsql-1", "")}-mysql-scraper"

    labels = {
      app = format("%.60s", md5("${var.service_name}${var.project}"))
    }

    namespace = var.namespace
  }

  spec {
    selector = {
      app = format("%.60s", md5("${var.service_name}${var.project}"))
    }

    template {
      restart_policy = "Always"

      volume {
        name = "secret-volume"

        secret {
          secret_name = kubernetes_secret.cloudsql.metadata[0].name
        }
      }

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

        image = "gcr.io/cloudsql-docker/gce-proxy"
        name  = "${var.service_name}-${replace(replace(var.project, "cabify-", ""), "-cloudsql-1", "")}-mysql-scraper-cloudsql"

        port {
          container_port = 3306
        }

        volume_mount {
          name       = "secret-volume"
          mount_path = "/etc/secret-volume"
        }

        command = ["/cloud_sql_proxy"]

        args = [
          "-instances=${var.project}:${var.instance_region}:${var.service_name}-master=tcp:0.0.0.0:3306",
          "-credential_file=/etc/secret-volume/credentials.json",
          "-dir=/root/cloudsql",
        ]
      }

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

        image = "prom/mysqld-exporter"
        name  = "${var.service_name}-${replace(replace(var.project, "cabify-", ""), "-cloudsql-1", "")}-mysql-scraper-scraper"

        port {
          container_port = 9104
        }

        env {
          name = "DATA_SOURCE_NAME"

          value_from {
            secret_key_ref {
              name = kubernetes_secret.cloudsql.metadata[0].name
              key  = "connection_string"
            }
          }
        }

        args = [
          "--collect.info_schema.clientstats",
          "--collect.info_schema.processlist",
          "--collect.engine_innodb_status",
          "--collect.info_schema.innodb_metrics",
        ]

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

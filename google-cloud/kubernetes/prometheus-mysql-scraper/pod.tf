resource "kubernetes_pod" "kubernetes_pod-mysql-scraper-module" {
  metadata {
    name = "${var.service_name}-mysql-scraper"
    labels {
      pod = "${var.service_name}-mysql-scraper"
    }
    namespace = "${kubernetes_namespace.prometheus-scrapers.metadata.0.name}"
  }

  spec {
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
      image = "gcr.io/cloudsql-docker/gce-proxy"
      name  = "${var.service_name}-mysql-scraper-cloudsql"
      port {
        container_port = 3306
      }
			volume_mount {
				name = "secret-volume"
				mount_path = "/etc/secret-volume"
			}
      command = ["/cloud_sql_proxy"]
      args = [
        "-instances=${var.project}:${var.instance_region}:${var.service_name}-master=tcp:0.0.0.0:3306",
        "-credential_file=/etc/secret-volume/gcloud-service-account-key",
        "-dir=/root/cloudsql",
      ]
    }
    container {
      image = "prom/mysqld-exporter"
      name  = "${var.service_name}-mysql-scraper-scraper"
      port {
        container_port = 9104
      }
      env {
        name = "DATA_SOURCE_NAME"
        value = "${var.user_name}:${var.user_password}@tcp(localhost)/"
      }
      args = [
        "--collect.engine_innodb_status",
        "--collect.info_schema.innodb_metrics",
      ]
    }
  }
}

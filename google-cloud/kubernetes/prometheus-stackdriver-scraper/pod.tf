resource "kubernetes_pod" "stackdriver_scraper" {
  metadata {
    name = "${var.service}-stackdriver-scraper"
    labels {
      pod = "${var.service}-stackdriver-scraper"
    }
    namespace = "${var.namespace}"
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
      image = "frodenas/stackdriver-exporter"
      name  = "${var.service}-stackdriver-exporter"
      port {
        container_port = 9225
      }
			volume_mount {
				name = "secret-volume"
				mount_path = "/etc/secret-volume"
			}
      env {
        name = "GOOGLE_APPLICATION_CREDENTIALS"
        value = "/etc/secret-volume/gcloud-service-account-key"
      }
      args = "${var.args}"
    }
  }
}

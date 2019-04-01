resource "kubernetes_service" "cloudsql" {
  metadata {
    annotations {
      prometheus_io_scrape = "true"
      prometheus.io/scrape = "persistence"
    }

    name      = "${kubernetes_replication_controller.cloudsql.metadata.0.name}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.cloudsql.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 9104
      target_port = 9104
    }

    type = "ClusterIP"
  }
}

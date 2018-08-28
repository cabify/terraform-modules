resource "kubernetes_service" "prometheus" {
  metadata {
    annotations {
      prometheus_io_scrape = "true"
    }

    name      = "${kubernetes_replication_controller.prometheus.metadata.0.name}"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.prometheus.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = "${var.prometheus-port}"
      target_port = "${var.prometheus-port}"
    }
  }
}

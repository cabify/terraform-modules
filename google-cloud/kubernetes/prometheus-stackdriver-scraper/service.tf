resource "kubernetes_service" "stackdriver" {
  metadata {
    annotations {
      prometheus_io_scrape = "true"
    }

    name      = "${kubernetes_replication_controller.stackdriver.metadata.0.name}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.stackdriver.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 9255
      target_port = 9255
    }

    type = "ClusterIP"
  }
}

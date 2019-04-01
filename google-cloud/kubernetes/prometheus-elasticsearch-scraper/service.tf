resource "kubernetes_service" "elasticsearch" {
  metadata {
    annotations {
      prometheus_io_scrape = "persistence"
      prometheus_io_environment = "${var.environment}"
    }

    name      = "${kubernetes_replication_controller.elasticsearch.metadata.0.name}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.elasticsearch.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = "${var.container_port}"
      target_port = "${var.container_port}"
    }

    type = "ClusterIP"
  }
}

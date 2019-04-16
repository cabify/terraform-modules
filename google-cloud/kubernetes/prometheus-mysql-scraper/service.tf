resource "kubernetes_service" "cloudsql" {
  metadata {
    annotations {
      prometheus_io_scrape      = "persistence"
      prometheus_io_environment = "${replace(var.project,"cabify-","")}"
      prometheus_io_service     = "${var.service_name}"
      prometheus_io_ownder      = "${var.owner}"
      prometheus_io_tier        = "${var.tier}"
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

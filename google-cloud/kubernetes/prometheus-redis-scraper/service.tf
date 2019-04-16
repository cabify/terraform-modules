resource "kubernetes_service" "redis" {
  metadata {
    annotations {
      prometheus_io_scrape      = "persistence"
      prometheus_io_environment = "${replace(var.project,"cabify-","")}"
      prometheus_io_service     = "${var.service}"
      prometheus_io_ownder      = "${var.owner}"
      prometheus_io_tier        = "${var.tier}"
    }

    name      = "${kubernetes_replication_controller.redis.metadata.0.name}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.redis.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = "${var.container_port}"
      target_port = "${var.container_port}"
    }

    type = "ClusterIP"
  }
}

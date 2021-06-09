resource "kubernetes_service" "prometheus" {
  metadata {
    annotations = {
      prometheus_io_scrape = var.prometheus_io_scrape
    }

    name      = kubernetes_replication_controller.prometheus.metadata.0.name
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_replication_controller.prometheus.metadata.0.labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = var.prometheus-port
      target_port = var.prometheus-port
    }
  }
}

resource "kubernetes_service" "trickster" {
  metadata {
    annotations = {
      prometheus_io_scrape = var.prometheus_io_scrape
      prometheus_io_port   = var.trickster_metrics_port
    }

    name      = "trickster-${kubernetes_replication_controller.prometheus.metadata.0.name}"
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_replication_controller.prometheus.metadata.0.labels.app
    }

    session_affinity = "ClientIP"

    port {
      name        = "trickster-port"
      port        = var.trickster_port
      target_port = var.trickster_port
    }

    port {
      name        = "trickster-metrics-port"
      port        = var.trickster_metrics_port
      target_port = var.trickster_metrics_port
    }
  }
}

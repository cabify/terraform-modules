resource "kubernetes_service" "exporter" {
  metadata {
    annotations = {
      prometheus_io_scrape      = var.prometheus-scrape-flag-exporter
      prometheus_io_environment = replace(var.aws_account, "cabify-", "")
      prometheus_io_service     = "${replace(var.aws_account, "cabify-", "")}-${var.name}-exporter"
      prometheus_io_owner       = var.owner
      prometheus_io_tier        = var.tier
      prometheus_io_path        = "/metrics"
    }

    name      = kubernetes_deployment.exporter.metadata.0.name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.exporter.metadata.0.labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 5000
      target_port = 5000
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "external-service" {
  metadata {
    annotations {
      prometheus_io_scrape = "true"
    }

    name      = "${var.name}"
    namespace = "${var.namespace}"
  }

  spec {
    port {
      port        = "${var.port}"
      target_port = "${var.port}"
    }
  }
}

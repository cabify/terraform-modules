resource "kubernetes_service" "external-service" {
  metadata {
    annotations {
      prometheus_io_https_scrape = "${var.https == "true" ? "true" : "false"}"
      prometheus_io_scrape       = "${var.https != "true" ? "true" : "false"}"
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

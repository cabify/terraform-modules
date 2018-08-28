resource "kubernetes_service" "external-service" {
  metadata {
    annotations {
      prometheus_io_https_scrape = "${var.https == "true" ? "true" : "false"}"
      prometheus_io_scrape       = "${var.https != "true" ? "true" : "false"}"
      instance                   = "${var.fqdn}:${var.port}"
    }

    fqdn      = "${var.fqdn}"
    name      = "${var.name}"
    namespace = "${var.namespace}"
  }

  spec {
    external_name = "${var.fqdn}"
    type          = "ExternalName"

    port {
      port        = "${var.port}"
      target_port = "${var.port}"
    }
  }
}

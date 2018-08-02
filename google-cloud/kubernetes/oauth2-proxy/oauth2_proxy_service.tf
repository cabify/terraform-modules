resource "kubernetes_service" "oauth2_proxy" {
  metadata {
    name      = "oauth2-proxy"
    namespace = "${var.oauth2_proxy_deployment_namespace}"
  }

  spec {
    selector {
      app = "oauth2-proxy"
    }

    session_affinity = "ClientIP"

    port {
      port        = 4180
      target_port = 4180
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_service" "prometheus-kubernetes_service" {
  metadata {
    name      = "${kubernetes_replication_controller.prometheus-kubernetes_replication_controller.metadata.0.name}"
    namespace = "${kubernetes_namespace.prometheus-scrapers.metadata.0.name}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.prometheus-kubernetes_replication_controller.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 9090
      target_port = 9090
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_persistent_volume_claim" "prometheus-server-data" {
  metadata {
    name      = "prometheus-server-data"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    storage_class_name = "ssd"

    resources {
      requests {
        storage = "120Gi"
      }
    }
  }

  depends_on = ["kubernetes_storage_class.ssd"]
}

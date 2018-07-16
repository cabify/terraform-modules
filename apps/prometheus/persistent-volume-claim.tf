resource "kubernetes_persistent_volume_claim" "prometheus-server-data-kubernetes_persistent_volume_claim" {
  metadata {
    name      = "prometheus-server-data"
    namespace = "${kubernetes_namespace.prometheus-scrapers.metadata.0.name}"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    storage_class_name = "ssd"

    resources {
      requests {
        storage = "3Gi"
      }
    }
  }

  depends_on = ["kubernetes_storage_class.ssd-kubernetes_storage_class"]
}

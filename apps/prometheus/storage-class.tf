resource "kubernetes_storage_class" "ssd" {
  metadata {
    name = "prometheus-ssd"
  }

  storage_provisioner = "kubernetes.io/gce-pd"

  parameters {
    type = "pd-ssd"
  }
}

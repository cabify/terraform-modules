resource "kubernetes_storage_class" "ssd-kubernetes_storage_class" {
  metadata {
    name = "ssd"
  }

  storage_provisioner = "kubernetes.io/gce-pd"

  parameters {
    type = "pd-ssd"
  }
}

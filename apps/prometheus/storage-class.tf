resource "kubernetes_storage_class" "ssd" {
  metadata {
    name = "${var.prometheus-storageclass"
  }

  storage_provisioner = "kubernetes.io/gce-pd"

  parameters {
    type = "pd-ssd"
  }
}

resource "kubernetes_secret" "kubernetes_secret_module" {
  metadata {
    name      = "${var.service}-secrets"
    namespace = "${var.namespace}"
  }

  data {
    gcloud-service-account-key = "${file("${var.service_account_file}")}"
  }
}

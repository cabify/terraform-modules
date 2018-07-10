resource "kubernetes_secret" "kubernetes_secret_module" {
  metadata {
    name      = "${var.service_name}-secrets"
    namespace = "${var.namespace}"
  }

  data {
    connection_string          = "${var.user_name}:${var.user_password}@tcp(localhost)/"
    gcloud-service-account-key = "${file("${var.service_account_file}")}"
  }
}

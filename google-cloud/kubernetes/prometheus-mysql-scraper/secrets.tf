resource "kubernetes_secret" "kubernetes_secret_module" {

  metadata {
    name = "${var.service_name}-secrets"
    namespace = "${kubernetes_namespace.prometheus-scrapers.metadata.0.name}"
  }

  data {
    gcloud-service-account-key = "${file("/home/jason/.gcp/staging.json")}"
  }

}


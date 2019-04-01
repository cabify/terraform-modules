resource "kubernetes_secret" "cloudsql" {
  metadata {
    name      = "${var.service_name}-${replace(var.project,"cabify-","")}-secrets"
    namespace = "${var.namespace}"
  }

  data {
    connection_string = "${var.user_name}:${var.user_password}@tcp(localhost)/"
    credentials.json  = "${base64decode(google_service_account_key.cloudsql.private_key)}"
  }
}

resource "kubernetes_secret" "stackdriver" {
  metadata {
    name      = "${var.service}-${replace(var.project, "cabify-", "")}-stackdriver-application-credentials"
    namespace = var.namespace
  }

  data = {
    credentials.json = base64decode(google_service_account_key.stackdriver.private_key)
  }
}


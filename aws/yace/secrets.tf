resource "kubernetes_secret" "exporter" {
  metadata {
    name      = "${replace(var.aws_account, "cabify-", "")}-${var.name}-yace-exporter"
    namespace = var.namespace
  }

  data = {
    aws_access_key = var.exporter_key
    aws_secret_key = var.exporter_secret
    aws_role_arn   = var.exporter_role_arn
  }
}

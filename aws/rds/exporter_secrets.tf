resource "kubernetes_secret" "rds" {
  metadata {
    name      = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-rds-secrets"
    namespace = var.namespace
  }

  data = {
    exporter_username = var.exporter_username
    exporter_password = var.exporter_password
    exporter_hostname = aws_db_instance.primary.address
  }
}

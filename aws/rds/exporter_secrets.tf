resource "kubernetes_secret" "rds" {
  metadata {
    name      = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-rds-secrets"
    namespace = var.namespace
    
    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}"))
      owner = var.owner
      tier = var.tier
      ssot = "persistence-tf"
    }
  }

  data = {
    exporter_username = var.exporter_username
    exporter_password = var.exporter_password
    exporter_hostname = aws_db_instance.primary.address
  }
}

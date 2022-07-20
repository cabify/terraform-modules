resource "kubernetes_config_map" "sql_exporter_querries" {
  metadata {
    name      = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-sql-exporter-q"
    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
      instance = var.instance_name
      owner = var.owner
      tier = var.tier
      ssot = "persistence-tf"
    }
    namespace = var.namespace
  }

  data = {
    "mysql.yml" = templatefile("${path.module}/exporter_sql_querries_mysql.yml", kubernetes_secret.sql_exporter.data)
  }
}

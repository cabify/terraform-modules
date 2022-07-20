resource "kubernetes_secret" "sql_exporter" {
  metadata {
    name      = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-sql-exporter-s"
    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
      owner = var.owner
      tier = var.tier
    }
    namespace = var.namespace
  }

  data = {
    app_username      = var.application_username
    gcp_username      = var.replication_gcp_username
    exporter_username = var.exporter_username
    exporter_password = var.exporter_password
    exporter_hostname = aws_db_instance.primary.address
  }
}

resource "kubernetes_secret" "sql_exporter_config" {
  metadata {
    name      = "${var.instance_name}-${replace(var.aws_account, "cabify-", "")}-sql-exporter-c"
    labels = {
      app = format("%.60s", md5("${var.instance_name}${var.aws_account}-sql-exporter"))
      owner = var.owner
      tier = var.tier
    }
    namespace = var.namespace
  }

  data = {
    //exporter_username = mysql_user.exporter.user
    "config.yml" = templatefile("${path.module}/exporter_sql_config.yml", kubernetes_secret.sql_exporter.data)
  }
}

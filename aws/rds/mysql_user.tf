// add new application user
resource "mysql_user" "appuser" {
  user               = var.application_username
  plaintext_password = var.application_password
  host               = "%"
  tls_option         = "SSL"
}

resource "mysql_user" "exporter" {
  user               = var.exporter_username
  plaintext_password = var.exporter_password
  host               = "%"
  tls_option         = "SSL"
}

resource "mysql_user" "replication" {
  count              = var.replication_enabled == true ? 1 : 0
  user               = var.replication_gcp_username
  plaintext_password = var.replication_gcp_password
  host               = "%"
  // tls_option = "SSL" // we will not force the old user to connect via ssl, since some apps might have issues
}

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

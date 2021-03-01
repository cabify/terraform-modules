resource "mysql_grant" "appgrant" {
  user       = mysql_user.appuser.user
  host       = mysql_user.appuser.host
  database   = mysql_database.appdb.name
  privileges = ["ALL PRIVILEGES"]
  // privileges = ["SELECT", "UPDATE","INSERT","DELETE"]

  tls_option = "SSL"
}

resource "mysql_grant" "exporter" {
  user       = mysql_user.exporter.user
  host       = mysql_user.exporter.host
  database   = "*"
  privileges = ["PROCESS", "REPLICATION CLIENT", "SELECT"]
  tls_option = "SSL"
}

resource "mysql_grant" "replication" {
  count      = var.replication_enabled == true ? 1 : 0
  user       = var.replication_gcp_username
  database   = mysql_database.appdb.name
  host       = mysql_user.replication[0].host
  privileges = ["ALL PRIVILEGES"]
  // tls_option = "SSL" // we will not force the old user to connect via ssl, since some apps might have issues
}

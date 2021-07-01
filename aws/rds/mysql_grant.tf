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

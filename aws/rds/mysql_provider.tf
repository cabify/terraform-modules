# Configure the MySQL provider based on the outcome of
# creating the aws_db_instance.
provider "mysql" {
  endpoint = aws_db_instance.primary.endpoint
  username = aws_db_instance.primary.username
  password = aws_db_instance.primary.password

  bastion_host = var.bastion_host
  bastion_port = var.bastion_port
  bastion_user = var.bastion_user

  tls      = "cert"
  tls_cert = "/root/.config/rds-combined-ca-bundled.pem"
}

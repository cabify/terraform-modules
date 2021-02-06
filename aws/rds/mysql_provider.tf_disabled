# Configure the MySQL provider based on the outcome of
# creating the aws_db_instance.
provider "mysql" {
  endpoint = aws_db_instance.primary.endpoint
  username = aws_db_instance.primary.username
  password = aws_db_instance.primary.password
  tls      = true
}


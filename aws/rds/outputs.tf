// not multi-az, so only one ip
output "aws_dms_replication_instance_public_ip" {
  value = aws_dms_replication_instance.replicate.*.replication_instance_public_ips
}

output "aws_db_instance_public_ip" {
  value = aws_db_instance.primary.endpoint
}

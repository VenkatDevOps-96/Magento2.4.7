output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_instance_id" {
  value = aws_db_instance.this.id
}

output "rds_address" {
  value = aws_db_instance.this.address
}

output "rds_arn" {
  value = aws_db_instance.this.arn
}


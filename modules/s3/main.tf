resource "aws_s3_bucket" "ami_backup" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}


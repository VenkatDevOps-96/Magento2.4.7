resource "aws_db_subnet_group" "magento" {
  name       = "magento-rds-subnet-group"
  subnet_ids = [
    "subnet-0844e1c7c0062ee6f",  # Private-App
    "subnet-0f1ba7ce386ac9cf9",  # Private-DB
  ]

  tags = {
    Name = "Magento-RDS-SubnetGroup"
  }
}


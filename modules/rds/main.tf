resource "aws_db_instance" "this" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = var.subnet_group
  multi_az                = var.multi_az
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = var.deletion_protection

  tags = merge(
    {
      Name = var.identifier
    },
    var.tags
  )
}


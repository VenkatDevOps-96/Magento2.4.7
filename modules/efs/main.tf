resource "aws_efs_file_system" "this" {
  creation_token = var.name
  encrypted      = true

  tags = {
    Name = var.name
  }
}

resource "aws_efs_mount_target" "private_subnet_1" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.private_subnet_1
  security_groups = [var.security_group_id]
}

resource "aws_efs_mount_target" "private_subnet_2" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.private_subnet_2
  security_groups = [var.security_group_id]
}


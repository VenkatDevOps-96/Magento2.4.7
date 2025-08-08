resource "aws_ami_from_instance" "backup" {
  name               = "${var.name_prefix}-${timestamp()}"
  source_instance_id = var.instance_id
  description        = "Automated backup of instance ${var.instance_id}"
  tags = {
    Name = "AutomatedBackup"
  }
}

variable "name" {
  type        = string
  description = "Name of the launch template"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH"
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)

  network_interfaces {
    security_groups = var.security_group_ids
    associate_public_ip_address = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "id" {
  value = aws_launch_template.this.id
}

output "latest_version" {
  value = aws_launch_template.this.latest_version
}


resource "aws_launch_template" "app_lt" {
  name_prefix   = "magento-app-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  # Add any other launch template settings you need, like security groups, key name, etc.

  lifecycle {
    create_before_destroy = true
  }
}


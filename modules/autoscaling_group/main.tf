variable "name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}

variable "launch_template_id" {
  type        = string
  description = "Launch template ID"
}

variable "launch_template_version" {
  type        = string
  description = "Launch template version to use"
  default     = "$Latest"
}

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "List of subnet IDs for ASG"
}

variable "desired_capacity" {
  type        = number
  default     = 2
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 4
}

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.vpc_zone_identifier

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_nlb_attachment" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn   = var.nlb_target_group_arn
}


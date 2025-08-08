variable "vpc_id" {
  type        = string
  description = "VPC ID for the load balancer and target groups"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "Security Group ID for the ALB"
}


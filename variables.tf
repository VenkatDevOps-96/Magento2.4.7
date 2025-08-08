variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "private_subnet_1_id" {
  description = "Private Subnet 1 for NLB"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Private Subnet 2 for NLB"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}


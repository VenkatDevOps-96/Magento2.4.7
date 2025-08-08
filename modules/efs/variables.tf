variable "name" {
  description = "Name of the EFS"
  type        = string
}

variable "private_subnet_1" {
  description = "First private subnet for mount target"
  type        = string
}

variable "private_subnet_2" {
  description = "Second private subnet for mount target"
  type        = string
}

variable "security_group_id" {
  description = "EFS security group ID"
  type        = string
}


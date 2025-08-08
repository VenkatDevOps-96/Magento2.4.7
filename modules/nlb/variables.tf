variable "subnet_ids" {
  description = "Subnets for NLB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "Magento-VPC"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.4.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1d"]
}

variable "igw_name" {
  type    = string
  default = "Magento-IGW"
}

variable "nat_name" {
  type    = string
  default = "Magento-NAT"
}

variable "public_rt_name" {
  type    = string
  default = "Public-RT"
}

variable "private_rt_name" {
  type    = string
  default = "Private-RT"
}


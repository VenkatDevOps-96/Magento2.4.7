variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "user_data" {
  description = "User data script to initialize the instance"
  type        = string
  default     = "" # Optional: if you want this to be optional
}


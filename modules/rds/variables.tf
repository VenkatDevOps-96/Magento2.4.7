variable "identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance type for RDS"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size (in GB)"
  type        = number
  default     = 50
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "username" {
  description = "Master DB username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  description = "Security group IDs for the RDS instance"
  type        = list(string)
}

variable "subnet_group" {
  description = "RDS subnet group name"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}


terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.8"
    }
  }

  backend "s3" {
    bucket         = "magento247-terraform-state"   # Your existing S3 bucket for terraform state
    key            = "magento/terraform.tfstate"    # Path inside the bucket
    region         = "us-east-1"                     # AWS region
    encrypt        = true
    dynamodb_table = "terraform-lock-table"          # Optional: for state locking (create this DynamoDB table if you want locking)
  }
}

provider "aws" {
  region = var.aws_region
}


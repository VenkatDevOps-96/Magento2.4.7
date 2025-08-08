module "vpc_networking" {
  source = "./modules/vpc_networking"

  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.4.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]

  # other variables if needed
}

module "security_groups" {
  source   = "./modules/security_groups"
  vpc_id   = "vpc-097b04327a4c3cbbe"
  admin_ip = "106.51.80.19/32"
}

module "bastion_instance" {
  source            = "./modules/ec2_instance"
  name              = "Bastion-Host"
  ami               = "ami-0a7d80731ae1b2435"  # Replace with actual AMI
  instance_type     = "t3.medium"
  subnet_id         = "subnet-07ac857e4cadec4a0"  # Public subnet
  security_group_ids = [module.security_groups.bastion_sg_id]
  key_name          = "magento-key"
  associate_public_ip = true
  root_volume_size  = 100

  tags = {
    "Role" = "Bastion"
  }
}

module "varnish_instance" {
  source            = "./modules/ec2_instance"
  name              = "Varnish-Server"
  ami               = "ami-0a7d80731ae1b2435"  # Replace with actual AMI
  instance_type     = "t3.medium"
  subnet_id         = "subnet-0e435f008db8b42b6"  # Public subnet
  security_group_ids = [module.security_groups.varnish_sg_id]
  key_name          = "magento-key"
  associate_public_ip = true
  root_volume_size  = 100

  tags = {
    "Role" = "Varnish"
  }
}

module "rds" {
  source              = "./modules/rds"
  identifier          = "magento-rds"
  db_name             = "magento"
  username            = var.db_username
  password            = var.db_password
  allocated_storage   = 50
  instance_class      = "db.m5.xlarge"
  engine              = "mysql"
  engine_version      = "8.0"
  security_group_ids  = ["sg-0d05e04f7b4602fff"] # Replace with RDS SG
  subnet_group        = "default-vpc-097b04327a4c3cbbe" # Or aws_db_subnet_group.magento.name
  multi_az            = false
  deletion_protection = false

  tags = {
    Environment = "Production"
    Application = "Magento"
  }
}

module "efs" {
  source            = "./modules/efs"
  name              = "magento-efs"
  private_subnet_1  = "subnet-0844e1c7c0062ee6f" # Private-App
  private_subnet_2  = "subnet-0f1ba7ce386ac9cf9" # Private-DB
  security_group_id = "sg-0f6ca177cc2116d5f"     # EFS SG
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc_networking.vpc_id
  public_subnet_ids = module.vpc_networking.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "nlb" {
  source     = "./modules/nlb"
  subnet_ids = [var.private_subnet_1_id, var.private_subnet_2_id]
  vpc_id     = module.vpc_networking.vpc_id
}

module "launch_template" {
  source = "./modules/launch_template"

  ami_id            = "ami-035dd7fc60ed66665"           # Your AMI ID
  instance_type     = "t3.medium"              # Your instance type
  security_group_ids = ["sg-09cf837ea2049c0dc"]  # Or the correct SG IDs
  name              = "magento-app-launch-template"   # Name for the launch template
}


module "autoscaling_group" {
  source = "./modules/autoscaling_group"

  name                    = "magento-ASG"
  launch_template_id      = module.launch_template.id
  launch_template_version = module.launch_template.latest_version
  vpc_zone_identifier     = var.private_subnet_ids
  desired_capacity        = 1
  min_size                = 1
  max_size                = 4
  nlb_target_group_arn    = module.nlb.app_nlb_tg_arn  # Pass the target group ARN here
}

module "magento_backups_prod" {
  source      = "./modules/s3_bucket"
  bucket_name = "magento-backups-prod"
  tags = {
    Environment = "prod"
    Purpose     = "AMI backups"
  }
}

module "s3_backup" {
  source       = "./modules/s3"
  bucket_name  = "magento-ami-backups"
  environment  = "prod"
}

module "ami_backup" {
  source       = "./modules/ami_backup"
  instance_id  = "i-03620142cd78db912" # replace with actual
  name_prefix  = "magento-backup"
}


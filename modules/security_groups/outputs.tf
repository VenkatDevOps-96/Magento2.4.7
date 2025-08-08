output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "varnish_sg_id" {
  value = aws_security_group.varnish.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "efs_sg_id" {
  value = aws_security_group.efs.id
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb_sg.id
}



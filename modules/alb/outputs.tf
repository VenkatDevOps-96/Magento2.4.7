output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.this.arn
}

output "app_target_group_arn" {
  description = "ARN of the app target group"
  value       = aws_lb_target_group.app_tg.arn
}

output "varnish_target_group_arn" {
  description = "ARN of the varnish target group"
  value       = aws_lb_target_group.varnish_tg.arn
}


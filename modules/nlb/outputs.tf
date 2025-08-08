output "nlb_arn" {
  value = aws_lb.this.arn
}

output "nlb_dns_name" {
  value = aws_lb.this.dns_name
}

output "app_nlb_tg_arn" {
  description = "ARN of the NLB target group for the app"
  value       = aws_lb_target_group.app_nlb_tg.arn
}


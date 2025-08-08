resource "aws_lb" "this" {
  name               = "magento-app-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_ids
  tags = {
    Name = "magento-app-nlb"
  }
}

resource "aws_lb_target_group" "app_nlb_tg" {
  name        = "magento-app-nlb-tg"
  port        = 8080
  protocol    = "TCP"           # TCP for actual traffic

  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"                 # HTTP health check
    path                = "/var/www/html/magento2/pub/healthcheck.html"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 6
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "tcp_8080" {
  load_balancer_arn = aws_lb.this.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_nlb_tg.arn
  }
}


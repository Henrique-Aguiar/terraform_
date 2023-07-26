data "aws_vpc" "default" {
  id = "vpc-0b0665db5a711964d"
}

resource "aws_lb" "meu_load_balancer" {
  name               = "meu-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = ["subnet-0b8c9ea9e67946f7c", "subnet-0bfb81f2135f9b4f4"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "meu_load_balancer" {
  load_balancer_arn = aws_lb.meu_load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.dves_cloud.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.meu_load_balancer.arn
  }
}

resource "aws_lb_target_group" "meu_load_balancer" {
  name     = "destino"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_target_group_attachment" "meu_load_balancer" {
  target_group_arn = aws_lb_target_group.meu_load_balancer.arn
  target_id        = aws_instance.api.id
  port             = 3000
}

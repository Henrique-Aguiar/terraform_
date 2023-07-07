resource "aws_lb" "vbncn" {
  name                       = "vbncn"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = ["subnet-0b8c9ea9e67946f7c"]
  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "vbncn" {
  load_balancer_arn = aws_lb.vbncn.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web2.arn
  }
}

resource "aws_lb_target_group" "web2" {
  name_prefix = "web2"
  port        = 443
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.web2.arn
  target_id        = aws_instance.web.id
  port             = 443
}
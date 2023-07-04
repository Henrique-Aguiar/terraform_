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

resource "aws_acm_certificate" "dves_cloud" {
  domain_name       = "dves.cloud"
  subject_alternative_names = [ "*.dves.cloud" ]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "dves_cloud" {
  certificate_arn         = aws_acm_certificate.dves_cloud.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_dves_cloud : record.fqdn]
}

resource "aws_route53_record" "validation_dves_cloud" {
  for_each = {
    for dvo in aws_acm_certificate.dves_cloud.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.dves_cloud.zone_id
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
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_target_group_attachment" "meu_load_balancer" {
  target_group_arn = aws_lb_target_group.meu_load_balancer.arn
  target_id        = aws_instance.web.id
  port             = 80
}

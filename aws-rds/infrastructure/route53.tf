resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_lb.lb_web_nginx.dns_name
    zone_id                = aws_lb.lb_web_nginx.zone_id
  }
}

resource "aws_route53_record" "api_dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "api"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.meu_load_balancer.dns_name]
}
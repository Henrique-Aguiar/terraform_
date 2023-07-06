resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_zone" "dves_private" {
  name = "dves.private"

  vpc {
    vpc_id = data.aws_vpc.default.id
  }
}

resource "aws_route53_record" "henrique_dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "henrique.dves.cloud"
  type    = "CNAME"
  ttl     = "300"
  records = ["dves.cloud"]
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_lb.vbncn.dns_name
    zone_id                = aws_lb.vbncn.zone_id
  }
}

resource "aws_route53_record" "mysql_dves_private" {
  zone_id = aws_route53_zone.dves_private.zone_id
  name    = "mysql.dves.private"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.mysql.private_ip]
}

resource "aws_route53_record" "server_dves_private" {
  zone_id = aws_route53_zone.dves_private.zone_id
  name    = "server.dves.private"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.private_ip]
}

resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}

resource "aws_route53_record" "henrique_dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "henrique"
  type    = "CNAME"
  ttl     = "300"
  records = ["dves.cloud"]
}


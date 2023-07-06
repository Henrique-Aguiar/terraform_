resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
          evaluate_target_health = true 
          name                   = "dualstack.meu-load-balancer-486811100.us-east-1.elb.amazonaws.com"
          zone_id                = "Z35SXDOTRQ7X7K" 
        }
  records = [aws_instance.web.public_ip]
}

resource "aws_route53_record" "henrique_dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "henrique"
  type    = "CNAME"
  ttl     = "300"
  records = ["dves.cloud"]
}


resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.dves_cloud_EAKKAIXXBA9BF.domain_name
    zone_id                = aws_cloudfront_distribution.dves_cloud_EAKKAIXXBA9BF.hosted_zone_id
  }
}


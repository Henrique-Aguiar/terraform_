resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.dves_cloud.domain_name
    zone_id                = aws_cloudfront_distribution.dves_cloud.hosted_zone_id
  }
}

resource "aws_route53_record" "api_dves_cloud" {
  name    = "api"
  type    = "A"
  zone_id = aws_route53_zone.dves_cloud.id

  alias {
    evaluate_target_health = false
    name                   = aws_api_gateway_domain_name.api_dves_cloud.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_dves_cloud.regional_zone_id
  }
}
resource "aws_route53_zone" "dves_cloud" {
  name = "dves.cloud"
}

resource "aws_route53_record" "dves_cloud" {
  zone_id = aws_route53_zone.dves_cloud.zone_id
  name    = "dves.cloud"
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_s3_bucket_website_configuration.dves_cloud.website_domain
    zone_id                = aws_s3_bucket.dves_cloud.hosted_zone_id
  }
}


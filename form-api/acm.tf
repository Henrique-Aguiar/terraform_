resource "aws_acm_certificate" "dves_cloud" {
  domain_name               = "dves.cloud"
  subject_alternative_names = ["*.dves.cloud"]
  validation_method         = "DNS"
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

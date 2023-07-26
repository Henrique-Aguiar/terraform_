resource "aws_cloudfront_distribution" "dves_cloud" {
  origin {
    connection_attempts      = 3
    connection_timeout       = 10
    domain_name              = aws_lb.lb_web_nginx.dns_name
    origin_id                = aws_lb.lb_web_nginx.dns_name

    custom_origin_config {
             http_port                = 80
             https_port               = 443
             origin_keepalive_timeout = 5
             origin_protocol_policy   = "http-only"
             origin_read_timeout      = 30
             origin_ssl_protocols     = [
                 "TLSv1.2",
                ]
            }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  aliases             = ["dves.cloud"]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_lb.lb_web_nginx.dns_name
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_All"

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.dves_cloud.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

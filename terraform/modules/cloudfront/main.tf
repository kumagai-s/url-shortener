resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.s3_bucket_regional_domain_name
    origin_id   = var.s3_bucket_id

    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "for url shortener prod"
  default_root_object = "index.html"

  aliases = [var.alternate_domain_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_bucket_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "url-shortener-prod-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

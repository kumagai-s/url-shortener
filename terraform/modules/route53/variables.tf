variable "zone_id" {
  type        = string
  description = "The hosted zone ID for Route53."
}

variable "domain_name" {
  type        = string
  description = "The domain name for the URL shortener."
}

variable "cloudfront_domain_name" {
  type        = string
  description = "The domain name of the CloudFront distribution."
}

variable "cloudfront_hosted_zone_id" {
  type        = string
  description = "The hosted zone ID of the CloudFront distribution."
}

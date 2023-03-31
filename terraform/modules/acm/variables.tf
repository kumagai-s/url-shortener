variable "domain_name" {
  description = "The domain name for which to request a certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID for the domain"
  type        = string
}

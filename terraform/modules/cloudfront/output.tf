output "domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution."
}

output "hosted_zone_id" {
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
  description = "The hosted zone ID of the CloudFront distribution."
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.s3_distribution.arn
  description = "The ARN of the CloudFront distribution."
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "The ARN of the CloudFront Origin Access Identity (OAI) for accessing the S3 bucket."
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "cloudfront_oai_iam_arn" {
  type        = string
  description = "The ARN of the CloudFront Origin Access Identity (OAI) for accessing the S3 bucket."
}

variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "The regional domain name of the S3 bucket."
}

variable "s3_bucket_id" {
  type        = string
  description = "The id of the S3 bucket."
}

variable "alternate_domain_name" {
  type        = string
  description = "The alternate domain name for the CloudFront distribution."
}

output "s3_bucket_name" {
  value       = module.s3.bucket_name
  description = "The name of the S3 bucket used for storing shortened URLs."
}

output "lambda_function_arn" {
  value       = module.lambda.lambda_arn
  description = "The ARN of the Lambda function that processes URL shortening."
}

output "api_gateway_url" {
  value       = module.api_gateway.api_gateway_url
  description = "The base URL of the API Gateway for the URL shortening service."
}

output "cloudfront_domain_name" {
  value       = module.cloudfront.cloudfront_domain_name
  description = "The domain name of the CloudFront distribution for the URL shortening service."
}

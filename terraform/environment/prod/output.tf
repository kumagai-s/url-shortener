output "cloudfront_domain_name" {
  value       = module.cloudfront.domain_name
  description = "The domain name of the CloudFront distribution for the URL shortening service."
}

output "s3_bucket_name" {
  value       = module.s3.bucket_name
  description = "The name of the S3 bucket used for storing shortened URLs."
}

output "api_gateway_url" {
  value       = module.api_gateway.api_gateway_url
  description = "The base URL of the API Gateway for the URL shortening service."
}

output "api_gateway_authorization_role_arn" {
  value       = module.api_gateway.api_gateway_authorization_role_arn
  description = "The ARN of the IAM role for the API Gateway authorization."
}

output "lambda_deploy_role_arn" {
  value       = module.lambda-deploy-role.lambda_deploy_role_arn
  description = "The ARN of the IAM deploy role."
}

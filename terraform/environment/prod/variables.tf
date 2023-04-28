variable "aws_region" {
  type        = string
  default     = "ap-northeast-1"
  description = "The AWS region for deploying resources."
}

variable "lambda_function_name" {
  type        = string
  default     = "url-shortener-prod-lambda"
  description = "The function_name of the Lambda for naming function."
}

variable "iam_role_name" {
  type        = string
  default     = "url-shortener-prod-lambda-role"
  description = "The name of the IAM role for the Lambda function."
}

variable "iam_role_policy_name" {
  type        = string
  default     = "url-shortener-prod-lambda-role-policy"
  description = "The name of the IAM role policy for the Lambda function."
}

variable "s3_bucket_name" {
  type        = string
  default     = "url-shortener-prod-bucket"
  description = "The name of the S3 bucket used for storing shortened URLs."
}

variable "api_gateway_name" {
  type        = string
  default     = "url-shortener-prod-api"
  description = "The name of the API Gateway used for naming resources."
}

variable "api_gateway_api_key_name" {
  type        = string
  default     = "url-shortener-prod-api-key"
  description = "The name of the API Gateway used for API key."
}

variable "api_gateway_usage_plan_name" {
  type        = string
  default     = "url-shortener-prod-api-usage-plan"
  description = "The name of the API Gateway used for usage plan."
}

variable "route53_zone_id" {
  type        = string
  default     = "Z1005005LKRCONPBGC2M"
  description = "The hosted zone ID for Route53."
}

variable "domain_name" {
  type        = string
  default     = "short.servithink.co.jp"
  description = "The domain name for the URL shortening service."
}

variable "lambda_deploy_role_name" {
  type        = string
  default     = "url-shortener-prod-lambda-deploy-role"
  description = "The name of the IAM role for the Lambda function deploy."
}

variable "lambda_deploy_role_policy_name" {
  type        = string
  default     = "url-shortener-prod-lambda-deploy-role-policy"
  description = "The name of the IAM role policy for the Lambda function deploy."
}

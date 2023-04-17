variable "function_name" {
  type        = string
  description = "The function_name of the Lambda function."
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM role for the Lambda function."
}

variable "iam_role_policy_name" {
  type        = string
  description = "The name of the IAM role policy for the Lambda function."
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket used by the Lambda function."
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket used by the Lambda function."
}

variable "api_gateway_execution_arn" {
  type        = string
  description = "The ARN of the API Gateway execution role."
}

variable "api_gateway_shorten_resource_path" {
  type        = string
  description = "The path of the API Gateway resource."
}

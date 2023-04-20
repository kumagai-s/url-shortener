variable "api_gateway_authorization_role_name" {
  type        = string
  description = "The name of the IAM user for the API Gateway authorization."
}

variable "api_gateway_authorization_role_policy_name" {
  type        = string
  description = "The name of the IAM policy for the API Gateway authorization."
}

variable "name" {
  type        = string
  description = "The name to be used for naming resources."
}

variable "allowed_ip" {
  type        = string
  description = "The allowed_ip to be used for policy."
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN of the Lambda function to be invoked."
}

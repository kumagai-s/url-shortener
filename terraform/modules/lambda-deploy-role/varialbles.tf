variable "lambda_deploy_role_name" {
  type        = string
  description = "The name of the IAM role for the Lambda function deploy."
}

variable "lambda_deploy_role_policy_name" {
  type        = string
  description = "The name of the IAM role policy for the Lambda function deploy."
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN of the Lambda function to be invoked."
}

variable "name" {
  type        = string
  description = "The name to be used for naming resources."
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN of the Lambda function to be invoked."
}

variable "api_key_name" {
  type        = string
  description = "The name of the API key." 
}

variable "usage_plan_name" {
  type        = string
  description = "The name of the usage plan."
}
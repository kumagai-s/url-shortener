variable "name" {
  type        = string
  description = "The name to be used for naming resources."
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN of the Lambda function to be invoked."
}

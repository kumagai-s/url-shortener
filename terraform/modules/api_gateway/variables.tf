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

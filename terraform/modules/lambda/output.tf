output "lambda_invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "The ARN of the Lambda function."
}

output "lambda_arn" {
  value       = aws_lambda_function.this.arn
  description = "The ARN of the Lambda function."
}

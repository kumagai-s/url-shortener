output "lambda_invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "The ARN of the Lambda function."
}

output "lambda_arn" {
  value       = aws_lambda_function.shorten.arn
  description = "The ARN of the Lambda function."
}

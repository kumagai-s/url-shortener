output "lambda_deploy_role_arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM deploy role."
}

output "lambda_arn" {
  value       = aws_lambda_function.this.arn
  description = "The ARN of the Lambda function."
}

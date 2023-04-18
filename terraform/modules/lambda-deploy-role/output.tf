output "lambda_deploy_role_arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM deploy role."
}

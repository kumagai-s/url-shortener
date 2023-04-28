output "api_gateway_url" {
  value       = aws_api_gateway_deployment.this.invoke_url
  description = "The URL of the API Gateway."
}

output "api_gateway_execution_arn" {
  value       = aws_api_gateway_deployment.this.execution_arn
  description = "The ARN of the API Gateway execution role."
}

output "api_gateway_shorten_resource_path" {
  value       = aws_api_gateway_resource.shorten.path
  description = "The path of the API Gateway resource."
}

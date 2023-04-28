resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "for url shortener"
}

resource "aws_api_gateway_resource" "shorten" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "shorten"
}

resource "aws_api_gateway_method" "shorten_post" {
  rest_api_id      = aws_api_gateway_rest_api.this.id
  resource_id      = aws_api_gateway_resource.shorten.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "shorten_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.shorten.id
  http_method             = aws_api_gateway_method.shorten_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "prod"
  depends_on  = [
    aws_api_gateway_method.shorten_post,
    aws_api_gateway_integration.shorten_lambda
  ]
}

resource "aws_api_gateway_api_key" "this" {
  name = var.api_key_name
}

resource "aws_api_gateway_usage_plan" "this" {
  name        = var.usage_plan_name
  description = "Usage plan for url shortener"
  depends_on  = [aws_api_gateway_deployment.this]

  api_stages {
    api_id = aws_api_gateway_rest_api.this.id
    stage  = aws_api_gateway_deployment.this.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.this.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.this.id
}

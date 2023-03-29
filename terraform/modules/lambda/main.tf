resource "aws_lambda_function" "shorten" {
  function_name = var.function_name
  handler       = "main"
  runtime       = "go1.x"

  role      = aws_iam_role.lambda_exec.arn
  s3_bucket = var.s3_bucket_name

  tags = {
    Name = "url-shortener"
  }
}

resource "aws_iam_role" "this" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  name = var.iam_role_policy_name
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

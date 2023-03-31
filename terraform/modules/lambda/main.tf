data "archive_file" "this" {
  type        = "zip"
  source_dir  = "../../tmp"
  output_path = "../../tmp/function.zip"
}

resource "aws_lambda_function" "this" {
  filename      = data.archive_file.this.output_path
  function_name = var.function_name
  handler       = "main"
  runtime       = "go1.x"

  role      = aws_iam_role.this.arn
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

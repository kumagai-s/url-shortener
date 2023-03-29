resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"

  lifecycle_configuration {
    rule {
      id     = "expired_objects"
      status = "Enabled"

      action {
        type = "Delete"
        days = 90
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
        Principal = {
          AWS = var.cloudfront_oai_iam_arn
        }
      }
    ]
  })
}

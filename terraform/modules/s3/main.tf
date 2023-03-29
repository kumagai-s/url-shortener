resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name = "url-shortener"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id

  acl = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
      id     = "expired_objects"
      status = "Enabled"

      expiration {
        days = 90
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
        Resource = "${aws_s3_bucket.this.arn}/*"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "aws:SourceArn" = var.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}

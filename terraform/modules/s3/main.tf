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
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.main.arn]
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::070982547174:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # 特定のリポジトリの特定のブランチからのみ認証を許可する
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:servithink/url-shortener:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.lambda_deploy_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "this" {
  name = var.lambda_deploy_role_policy_name
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:UpdateFunctionConfiguration",
          "lambda:UpdateFunctionCode",
        ]
        Effect   = "Allow"
        Resource = "${var.lambda_invoke_arn}/*"
      }
    ]
  })
}
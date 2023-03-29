terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source                 = "./modules/s3"
  bucket_name            = var.s3_bucket_name
  cloudfront_oai_iam_arn = module.cloudfront.cloudfront_oai_iam_arn
}

module "lambda" {
  source               = "./modules/lambda"
  function_name        = var.lambda_function_name
  iam_role_name        = var.iam_role_name
  iam_role_policy_name = var.iam_role_policy_name
  s3_bucket_name       = module.s3.bucket_name
  s3_bucket_arn        = module.s3.bucket_arn
}

module "api_gateway" {
  source            = "./modules/api_gateway"
  name              = var.api_gateway_name
  lambda_invoke_arn = module.lambda.lambda_arn
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

module "route53" {
  source                    = "./modules/route53"
  zone_id                   = var.route53_zone_id
  domain_name               = var.domain_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

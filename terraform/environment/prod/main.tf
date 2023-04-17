terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.29.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name = "url-shortener"
    }
  }
}

module "s3" {
  source                      = "../../modules/s3"
  bucket_name                 = var.s3_bucket_name
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

module "lambda" {
  source               = "../../modules/lambda"
  function_name        = var.lambda_function_name
  iam_role_name        = var.iam_role_name
  iam_role_policy_name = var.iam_role_policy_name
  s3_bucket_name       = module.s3.bucket_name
  s3_bucket_arn        = module.s3.bucket_arn
  api_gateway_execution_arn         = module.api_gateway.api_gateway_execution_arn
  api_gateway_shorten_resource_path = module.api_gateway.api_gateway_shorten_resource_path
}

module "api_gateway" {
  source            = "../../modules/api_gateway"
  name              = var.api_gateway_name
  allowed_ip        = "183.77.231.76"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}

module "acm" {
  source          = "../../modules/acm"
  domain_name     = var.domain_name
  route53_zone_id = var.route53_zone_id
}

module "cloudfront" {
  source                         = "../../modules/cloudfront"
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  s3_bucket_id                   = module.s3.bucket_id
  domain_name                    = var.domain_name
  acm_certificate_arn            = module.acm.certificate_arn
}

module "route53" {
  source                    = "../../modules/route53"
  zone_id                   = var.route53_zone_id
  domain_name               = var.domain_name
  cloudfront_domain_name    = module.cloudfront.domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}

module lambda-deploy-role {
  source                         = "../../modules/lambda-deploy-role"
  lambda_deploy_role_name        = var.lambda_deploy_role_name
  lambda_deploy_role_policy_name = var.lambda_deploy_role_policy_name
  lambda_arn                     = module.lambda.lambda_arn
}

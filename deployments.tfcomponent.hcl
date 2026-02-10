# HCP Terraform issues an OIDC JWT for AWS
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  inputs = {
    region             = "us-east-1"
    role_arn           = "<REPLACE_WITH_DEV_ROLE_ARN>"
    identity_token     = identity_token.aws.jwt
    default_tags       = { environment = "dev", owner = "platform" }
    cluster_name       = "stacks-demo-dev"
    kubernetes_version = "1.30"
    vpc_cidr           = "10.100.0.0/16"
  }
}

deployment "staging" {
  inputs = {
    region             = "us-east-1"
    role_arn           = "<REPLACE_WITH_STAGING_ROLE_ARN>"
    identity_token     = identity_token.aws.jwt
    default_tags       = { environment = "staging", owner = "platform" }
    cluster_name       = "stacks-demo-stg"
    kubernetes_version = "1.30"
    vpc_cidr           = "10.101.0.0/16"
  }
}

deployment "production" {
  inputs = {
    region             = "us-west-2"
    role_arn           = "<REPLACE_WITH_PROD_ROLE_ARN>"
    identity_token     = identity_token.aws.jwt
    default_tags       = { environment = "prod", owner = "platform" }
    cluster_name       = "stacks-demo-prd"
    kubernetes_version = "1.30"
    vpc_cidr           = "10.102.0.0/16"
  }
}
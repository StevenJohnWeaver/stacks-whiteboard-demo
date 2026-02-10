required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.27"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5"
  }
}

provider "aws" "main" {
  config {
    region = var.region

    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }

    default_tags { tags = var.default_tags }
  }
}

# Smart Handshake: provider wired to EKS outputs from the 'cluster' component.
# Stacks will defer planning/applying 'app' until these are known.
provider "kubernetes" "main" {
  config {
    host                   = component.cluster.cluster_url
    cluster_ca_certificate = component.cluster.cluster_ca
    token                  = component.cluster.cluster_token
  }
}

provider "random" "main" {}
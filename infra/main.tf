terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"
    }
  }

  backend "s3" {
    bucket         = "data-processor-tf-state"
    key            = "dev.tfstate" # or use ${terraform.workspace}
    region         = "eu-central-1"
    use_lockfile   = true
    encrypt        = true
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  access_key = chomp(file("${var.path_to_aws_access_key}"))
  secret_key = chomp(file("${var.path_to_aws_secret_key}"))
}

provider "null" {
  # No configuration options
}
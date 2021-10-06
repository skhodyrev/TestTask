terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  access_key = chomp(file("${var.aws_access_key}"))
  secret_key = chomp(file("${var.aws_secret_key}"))
}

provider "tls" {
  # No configuration options
}

provider "null" {
  # No configuration options
}
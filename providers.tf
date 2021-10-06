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
  access_key = chomp(file("aws_cli_access.key")) //Put here path to your Amazon AWS access key
  secret_key = chomp(file("aws_cli_secret.key")) //Put here path to your Amazon AWS secret key
}

provider "tls" {
  # No configuration options
}

provider "null" {
  # No configuration options
}
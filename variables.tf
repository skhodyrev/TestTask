variable "aws_region" {
  default     = "eu-central-1"
  type        = string
  description = "AWS region for installation"
}

variable "back_count" {
  default     = 3
  type        = number
  description = "Number of backend nginx instances"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "VPC CIDR"
}

variable "subnet_cidr_newbits" {
  type        = number
  default     = 8
  description = "The newbits value as per cidrsubnet function docs"
}

variable "aws_access_key" {
  type        = string
  default     = "aws_cli_access.key"
  description = "Path to your Amazon AWS access key"  
}

variable "aws_secret_key" {
  type        = string
  default     = "aws_cli_secret.key"
  description = "Path to your Amazon AWS secret key"  
}

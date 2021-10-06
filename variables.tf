variable "aws_region" {
  default     = "eu-central-1"
  type        = string
  description = "AWS region for installation"
}

variable "back_count" {
  default     = 6
  type        = number
  description = "Number of backend nginx instances"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "VPC CIDR"

}

variable "subnet_cidr_newbits" {
  type        = string
  default     = 8
  description = "The newbits value as per cidrsubnet function docs"
}


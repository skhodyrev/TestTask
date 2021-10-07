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

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "AWS EC2 instance type"
}

variable "ami_id" {
  type        = string
  default     = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  description = "ID of Amazon Machine Image"
}

variable "username_ami" {
  type        = string
  default     = "ubuntu" //Ubuntu Server 20.04 LTS default username
  description = "Default user name for given AMI"
}
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

variable "username_ami" {
  type        = string
  default     = "ubuntu" //Ubuntu Server default username
  description = "Default user name for given AMI"
}

variable "ami_account_number" {
  default = "099720109477" //Canonical Owner ID
  description = "Owner ID for given AMI"
}

variable "ami_name" {
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  description = "Name of the AMI to use"
}

variable "path_to_bastion_private_key" {
  type        = string
  default     = "ssh_bastion.key"
  description = "Path to the Bastion pivate key"
}

variable "path_to_nginx_private_key" {
  type        = string
  default     = "ssh_nginx.key"
  description = "Path to the Nginx pivate key"
}

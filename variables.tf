variable "aws_region" {
  default     = "eu-central-1"
  type        = "string"
  description = "AWS region for installation"
}

variable "back_count" {
  default        = 3
  type           = "number"
  desdescription = "Number of backend nginx instances"
}

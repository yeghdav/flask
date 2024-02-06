variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "domain" {
  default = "orinak.link"
}

variable "project" {
  default = "flask"
}

variable "eks_version" {
  default = "1.29"
}

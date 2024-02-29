provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "flask-application-testing-us-east-1"
    dynamodb_table = "flask-application-testing-us-east-1"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
  }
}

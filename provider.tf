terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "terraform-state-bucket-poc-per"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    key            = "placeholder"
  }
}

provider "aws" {
  region = var.aws_region
}

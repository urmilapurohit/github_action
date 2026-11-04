terraform {
  required_version = ">= 1.5"

  backend "s3" {}
}

provider "aws" {
  region = "eu-west-1"
}

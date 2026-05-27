terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.46.0"
    }
  }

  required_version = ">= 1.5.0"

   backend "s3" {
    bucket         = "forbackendfile"   # replace with your bucket name
    key            = "prod/terraform.tfstate"      # path inside the bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"             # optional, for state locking
  }
}


provider "aws" {
  region = "us-east-1"
}

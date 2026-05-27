#variable "vpc_name" {type = string}
variable "cidr_block" {type = string}
variable "vpc_tag" {type = string}

variable "bucket_name" {type = string}



# Call the VPC module
module "vpc" {
  source = "./modules/vpc"
  #Name                 = var.vpc_name
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_tag
  }
}
# Call the S3 bucket module
module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}
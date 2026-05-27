variable "vpc_name" {type = string}
variable "virtual_network_cidr" {type = string}
variable "vpc_tag" {type = string}

variable "s3_name" {type = string}



# Call the VPC module
module "vpc" {
  source = "./modules/vpc"
  Name                 = var.vpc_name
  cidr_block           = var.virtual_network_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_tag
  }
}
# Call the S3 bucket module
module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = var.s3_name
  acl         = "private"
}
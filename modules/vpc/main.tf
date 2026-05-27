#variable "vpc_name" {type = string}
variable "cidr_block" {type = string}
variable "vpc_tag" {type = string}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  #vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_tag
  }
}
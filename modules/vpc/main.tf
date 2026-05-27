variable "vpc_name" {}
variable "virtual_network_cidr" {}
variable "vpc_tag" {}



# Create a VPC
resource "aws_vpc" "main_vpc" {
  vpc_name             = var.vpc_name
  cidr_block           = var.virtual_network_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_tag
  }
}



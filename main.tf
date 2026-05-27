#variable "vpc_name" {type = string}
variable "cidr_block" {type = string}
variable "vpc_tag" {type = string}

variable "bucket_name" {type = string}

variable "function_name" {type = string}
variable "func_role" {type = string}
variable "func_handler"{type = string}
variable "func_runtime"{type = string}

#variable "func_bucket"{type = string}
variable "buck_file"{type = string}

# Call the VPC module
module "vpc" {
  source = "./modules/vpc"
  #Name                 = var.vpc_name
  cidr_block           = var.cidr_block
  vpc_tag              = var.vpc_tag
}
# Call the S3 bucket module
module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

# Call the lambda module
module "lambda_function" {
  source = "./modules/lambda"
  function_name = var.function_name
  func_role     = var.func_role 
  func_handler  = var.func_handler
  func_runtime  = var.func_runtime
  func_bucket   = module.s3_bucket.func_bucket_name
  buck_file     = var.buck_file
  depends_on    = [module.s3_bucket]

# }
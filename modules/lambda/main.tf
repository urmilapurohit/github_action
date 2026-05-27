variable "function_name" {type = string}
variable "func_role" {type = string}
variable "func_handler"{type = string}
variable "func_runtime"{type = string}

variable "func_bucket"{type = string}
variable "buck_file"{type = string}


resource "aws_lambda_function" "simple_lambda" {
  function_name = var.function_name
  role          = var.func_role  # replace with your IAM role ARN
  handler       = var.func_handler
  runtime       = var.func_runtime

  # Deployment package (ZIP file must exist locally or in S3)
  s3_bucket = var.func_bucket
  s3_key    = var.buck_file
  environment {
    variables = {
      ENV = "dev"
    }
  }
}

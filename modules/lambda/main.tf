variable "function_name" {type = string}
variable "func_role" {type = string}
variable "func_handler"{type = string}
variable "func_runtime"{type = string}


resource "aws_lambda_function" "simple_lambda" {
  function_name = var.function_name
  role          = var.func_role  # replace with your IAM role ARN
  handler       = var.func_handler
  runtime       = var.func_runtime

  # Deployment package (ZIP file must exist locally or in S3)
#   filename         = "lambda_function_payload.zip"
#   source_code_hash = filebase64sha256("lambda_function_payload.zip")

  environment {
    variables = {
      ENV = "dev"
    }
  }
}

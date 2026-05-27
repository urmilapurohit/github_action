variable "bucket" {type = string}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket
  acl    = "private"
  tags = {
    Name        = "my-s3-bucket"
    Environment = "Dev"
  }
}
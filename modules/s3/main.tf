variable "bucket_name" {type = string}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  key    = "test.py.zip"          # name of the object in S3
  source = "/Users/urmila/Documents/lambda/index.py"  # full local path to the file
  acl    = "private"
  tags = {
    Name        = "my-s3-bucket"
    Environment = "Dev"
  }
}

output func_bucket_name {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "buck name"

}

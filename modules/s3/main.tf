variable "bucket_name" {type = string}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  tags = {
    Name        = "my-s3-bucket"
    Environment = "Dev"
  }
}


# Upload a file into the bucket
resource "aws_s3_object" "my_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "test.py.zip"   # name of the object in S3
  source = "${path.root}/data/test.py.zip"  # local path to your file
  acl    = "private"
}

output func_bucket_name {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "buck name"

}

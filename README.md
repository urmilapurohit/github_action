<!--  ------------------variables---------------------

In child file(module like s3) we can change var value like below:
resource "aws_s3_bucket" "my_bucket" {
bucket = var.bucket_name }

but we have to apply same var value in main file like below:
module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
} -->

<!-- wehn we apply terrafrom from github action then maintain the state file in s3 backend other everytime github actio runs, it will create new terraform infra

1.  create s3 and DynamoDB table for terraform
 spetps: DynamoBD >> table name: terraform-locks >> partition-keys: LockID -->
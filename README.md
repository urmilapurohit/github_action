--------------------------Terraform basics--------------------------

- In child file(module like s3/vpc) we can change var name like below example:

```hcl
  resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

  2. vresource "aws_vpc" "main_vpc" {
     cidr_block           = var.cidr_block_name }

- but we have to apply same var name (in child module) in to the main file like below example:
  1. module "s3_bucket" {
     source = "./modules/s3"
     bucket_name = var.bucket_name
}

  2.  module "vpc" {
      source = "./modules/vpc"
      cidr_block_name = var.cidr_block_name
}


------------------------Terraform notes while using it fron github action-----------------------

- When we apply terrafrom from github action then maintain the state file in s3 backend. Otherwise, everytime github action runs, it will create new terraform infrastructre and resources:

1. Create s3 and DynamoDB table for terraform:
 steps: DynamoBD >> table name: terraform-locks >> partition-keys: LockID

2. Add backend location in terraform providers file:
 - backend "s3" {
    bucket         = "forbackendfile"   # replace with your bucket name
    key            = "prod/terraform.tfstate"      # path inside the bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"             # optional, for state locking
  }


-------------------------Types of varibale-----------------------
 - At yml file level:  
- local variable can be define with scop like .yml file, jobs, steps  
- env:  
    cloud: aws

- At REPO level:  
- GitHub >> setting >> variable and secrets >> add variable  
- ${{var.my_var_name}}

- GitHub predefine variables(GitHub metadata):  
Example:

run: |
echo "This is ${{ github.repository }}"
echo "This is ${{ github.workflow }}"
echo "This is ${{ github.triggering_actor }}"
echo "This is ${{ secrets.GITHUB_TOKEN }}"


-  Secrets >>> This secrets can be created just like "REPO level variable":  
- GitHub >> setting >> variable and secrets >> add secrets  
- ${{ secrets.MY_SECRET }}

Reference link https://docs.github.com/en/actions/reference/workflows-and-actions/contexts

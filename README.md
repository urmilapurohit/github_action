- Check the code section:

<!--  

------------------Terraform notes while using from Github action---------------------

In child file(module like s3) we can change var value like below:
resource "aws_s3_bucket" "my_bucket" {
bucket = var.bucket_name }

but we have to apply same var value in main file like below:
module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
} -->

<!-- wehn we apply terrafrom from github action then maintain the state file in s3 backend other everytime github action runs, it will create new terraform infrastructre and resources

1.  create s3 and DynamoDB table for terraform
 spetps: DynamoBD >> table name: terraform-locks >> partition-keys: LockID -->

<!-- 

-------------------------Types of varibale-----------------------
 *At yml file level
- local variable can be define with scop like .yml file, jobs, steps
- env:
    cloud: aws

*At REPO level
- GitHub >> setting >> variable and secrets >> add variable
- ${{var.my_var_name}}


* GitHub predefine variables(GitHub metadata):
Example:
        run: |
          echo "This is ${{ github.repository }}"
          echo "This is ${{ github.workflow }}"
          echo "This is ${{ github.triggering_actor }}"
          echo "This is ${{ secrets.GITHUB_TOKEN }}"

* Secrets: This secrets can be created just like "REPO level variable"
- GitHub >> setting >> variable and secrets >> add secrets
- ${{ secrets.MY_SECRET }}


Reference linkhttps://docs.github.com/en/actions/reference/workflows-and-actions/contexts
 -->

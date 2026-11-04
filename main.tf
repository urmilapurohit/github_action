resource "aws_instance" "ec2" {
  ami           = "ami-0df368112825f8d8f" # Amazon Linux 2023 (eu-west-1)
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

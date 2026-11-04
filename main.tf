resource "aws_instance" "ec2" {
  ami           = "ami-0694d931cee176e7d" # Amazon Linux 2023 (eu-west-1)
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-ec2"
  }
}

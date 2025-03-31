provider "aws" {
  region = "us-east-1”  # Change to your AWS region
}

resource "aws_instance" "my_instance" {
  ami           = var.ami_id  # This is provided by the GitHub Action
  instance_type = "t2.micro"

  tags = {
    Name = "MyEC2Instance"
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

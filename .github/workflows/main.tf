provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}

resource "aws_instance" "my_instance" {
  ami           = var.ami_id  # The AMI ID passed from the workflow
  instance_type = "t2.micro"
  
  tags = {
    Name = "MyEC2Instance"
  }
}

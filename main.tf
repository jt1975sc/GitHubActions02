provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-08b5b3a93ed654d19"  
  instance_type = "t2.micro"
  key_name      = "AKIAQNO4QGTXRN7FZRDW" 
  security_groups = ["my-security-group"] 

  tags = {
    Name = "Terraform-EC2"
  }
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "my_first_ami_${local.timestamp}"
  instance_type = "t2.micro"
  region        = "${var.my_region}"

  # Provide the exact AMI ID here (make sure it's valid and exists in the region you're using)
  source_ami    = "${var.source_ami_id}"

  ssh_username  = "ubuntu"  # Default for Ubuntu AMIs
  communicator  = "none"    # Disables SSH access during the build process
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    source      = "app_files"
    destination = "/home/ubuntu/"
  }

  provisioner "shell" {
    inline = [
      "ls /home/ubuntu",
      "echo 'Install packages with apt'",
      "sudo apt install python3 -y",
      "sudo apt update -y",
      "sudo apt install python3-pip -y",
      "sudo snap install redis",
      "echo 'Install python packages with pip'",
      "sudo pip3 install -r app_files/requirements.txt",
      "echo 'Setup the my app service with systemd'",
      "sudo cp /home/ubuntu/app_files/myapp.service /etc/systemd/system/myapp.service",
      "sudo systemctl enable myapp",
    ]
  }
}

variable "my_region" {
  type    = string
  default = "us-east-1"  
}

variable "source_ami_id" {
  type    = string
  default = "ami-08b5b3a93ed654d19"  
}

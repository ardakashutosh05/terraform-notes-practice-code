provider "aws" {
  region     = "ap-southeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Datasource in terraform 
data "aws_ami" "ubuntu" {
  most_recent = 
  owners = ["099720109477"]

  # name = amazon/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20251015
  # root device type = ebs
  # vert type = hvm

  filter {
    name = "name"
    values = ["amazon/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
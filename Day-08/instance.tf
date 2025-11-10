terraform {
  backend "s3" {
    bucket = "ashu05-terraform-state-bucket"
    region = "ap-southeast-1"
    key    = "terraform.tfstate"
    dynamodb_table = "ashu-table-lock"
  }
}


variable "aws_access_key" {
  description = "The access key for the cloud provider"
  type        = string
}

variable "aws_secret_key" {
  description = "The secret key for the cloud provider"
  type        = string
}


provider "aws" {
  region     = "ap-southeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "web" {
  ami           = "ami-0933f1385008d33c4" # Amazon Linux 2 AMI
  instance_type = "t3.micro"
}
###
###
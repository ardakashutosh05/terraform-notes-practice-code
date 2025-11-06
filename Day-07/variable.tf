
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "instance_type" {
  description = "t2.micro"
  type        = string
}

variable "image_id" {
  description = "AMI ID"
  type        = string
}

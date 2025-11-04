variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}


variable "public_key" {
  description = "SSH public key in OpenSSH format"
  type        = string
}

variable "ports" {
  type = list(number)
}

variable "image_id" {
  type        = string
  description = "this is a ubuntu image id "
}

variable "instance_type" {
  type        = string
  description = "instance type"
}
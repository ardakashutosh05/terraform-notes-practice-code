variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "image_id" {
  description = "AMI ID"
  type        = string
}

variable "key_name" {
  description = "Name of SSH key pair"
  type        = string
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}

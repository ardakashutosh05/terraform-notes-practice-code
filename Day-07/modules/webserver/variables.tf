
variable "instance_type" {
  description = "t2.micro"
  default     = "t3.micro"
}

variable "image_id" {
  description = "AMI ID"
  type        = string
}

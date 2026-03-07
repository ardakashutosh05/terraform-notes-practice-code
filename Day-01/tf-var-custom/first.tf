variable age {
    type = number

}

variable "username" {
    type = string
}

output printname{

    value = "Hello, ${var.username}, your age is ${var.age}"
}
# you have two tfvars file and you need to chose one write 
# terraform plan -var-file=dev.tfvars
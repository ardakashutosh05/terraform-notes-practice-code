variable "usersage" {
    type = map 
    default = {
        ram = 20
        shri = 22 

    } 

}
variable "username" {
    type = string
}

output "userage" {

    value = " my name is ${var.username} and my age is ${lookup(var.usersage, "${var.username}")} "
}
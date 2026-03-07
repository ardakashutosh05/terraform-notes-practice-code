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

output "user" {

    value = " my name is ${var.username} and my age is ${lookup(var.usersage, "${var.username}")} "
}
# lookup man je default or -var madhe age ghe to
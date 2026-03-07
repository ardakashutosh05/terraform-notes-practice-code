output printfirst {
   value = " first user is ${var.users[1]}"
}

output printfir {
   value =  var.users
}

output print {
   value = "${join(",",var.users)}"
}

output helloworldupper {
   value = "${upper(var.users[0])}"
}

output helloworldtitle {
   value = "${title(var.users[0])}"
}

output helloworldlower {
  value = "${lower(var.users[1])}"
}

output hellowold {
    value = "${join("--->",var.users)}"
}

#terraform plan -var "username=ashu" -var "age=23"
# is me -var ke bad valu pass karsak te hai diract 
terraform plan -var "username=AshutoshArdak" -var "age=20"
#terraform plan -var 'username=[ashu", "ram", "sham"]

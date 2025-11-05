
# creating ssh-key
resource "aws_key_pair" "key-tf1" {
  key_name   = "key-tf"
  public_key = var.public_key

}

#< public_key = file("${path.module}/id_rsa.pud")

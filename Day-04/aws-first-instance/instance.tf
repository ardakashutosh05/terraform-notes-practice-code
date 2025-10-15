# creating ssh-key
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = var.public_key
}

# public_key = file("${path.module}/id_rsa.pud")
#

resource "aws_instance" "web" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key-tf.key_name
  tags = {
   Name = "my-first-tf-instance"
 }
}

 
 # instance
 resource "aws_instance" "web" {
  ami           = var.image_id
  instance_type = var.instance_type

  tags = {
    Name = "ModuleDirectRun"
  }


  #key_name               = aws_key_pair.key-tf.key_name
}

resource "aws_key_pair" "key-tf" {
    key_name   = "key-tf"
    public_key = file("~/.ssh/id_rsa.pub")
  }
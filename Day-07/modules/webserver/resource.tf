
resource "aws_key_pair" "key" {
    key_name   = "var.key_name"
    public_key = var.public_key
  }

 # intance
 resource "aws_instance" "web" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name

  tags = {
    Name = "ModuleDirectRun"
  }


  #key_name               = aws_key_pair.key-tf.key_name
}

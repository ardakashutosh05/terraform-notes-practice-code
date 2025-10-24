

# creating instance
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "my-first-tf-instance"
  }
  user_data = file("${path.module}/script.sh")
}


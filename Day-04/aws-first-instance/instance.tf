
# creating ssh-key
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = var.public_key
}

#< public_key = file("${path.module}/id_rsa.pud")

# creating security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow common inbound ports (22, 80, 443, 3306, 27017)"

  # Dynamic ingress rule for multiple ports
  dynamic "ingress" {
    for_each = [22, 80, 443, 3306, 27017]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# creating instance
resource "aws_instance" "web" {
  ami             = "ami-0933f1385008d33c4"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "my-first-tf-instance"
  }
}


# creating security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_2"
  description = "Allow common inbound ports (22, 80, 443, 3306, 27017)"

  # Dynamic ingress rule for multiple ports
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}







/*
# creating ssh-key
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = var.public_key
}
*/
#< public_key = file("${path.module}/id_rsa.pud")

# creating security group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_22" {
  security_group_id = aws_security_group.allow_tls.id
   cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_443" {
  security_group_id = aws_security_group.allow_tls.id
   cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_80" {
  security_group_id = aws_security_group.allow_tls.id
   cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3306" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_27017" {
  security_group_id = aws_security_group.allow_tls.id
   cidr_ipv4         = "0.0.0.0/0"
  from_port         = 27017
  ip_protocol       = "tcp"
  to_port           = 27017
}


/*
resource "aws_instance" "web" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key-tf.key_name
  tags = {
   Name = "my-first-tf-instance"
 }
}
*/
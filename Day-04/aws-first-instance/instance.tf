resource "aws_instance" "web" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-instance"
  }
}

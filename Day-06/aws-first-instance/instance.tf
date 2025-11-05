
# datasource in terraform 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# creating instance
resource "aws_instance" "web" {
  #ami                    = var.image_id
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf1.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls1.id]

  tags = {
    Name = "my-first-tf-instance"
  }
  user_data = file("${path.module}/script.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }

  # file, local-exec, remote-exec
  provisioner "file" {
    source      = "readme.md"      # terraform machine
    destination = "/tmp/readme.md" # remote machine
  }



  provisioner "local-exec" { # local-exec it work on local machin run that commant on local in terraform 
    #on_failure = continue
    #when = destroy
    command = "env>env.txt"
    environment = {
      envname = "envvalue"
    }
  }


  # file, local-exec, remote-exec
  provisioner "remote-exec" { # jo bhiapka resorsr creat ho ga uske an dar run higa 
    inline = [
      "echo 'This is test content created by Terraform!' > /tmp/content.md"
    ]
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mypublicip.txt "
  }
}


output "instance_public_ip" {
  description = "The public ip address"
  value       = aws_instance.web.public_ip
}
# terraform one time apply ho gaya to fi aga ham ne script me chang kiya to terraform ko nahi pata chle ga ya fir se apply kito chang nahi hoga is kiy ansebale ply bok use hota terraform sirf plat form risorse manag kar ta hai 
🧭 Terraform Notes — Part 5 (Topics 31–40)
31️⃣ Create First Resource (Manual Steps) on AWS (EC2 Instance)

Before using Terraform, understand how to create resources manually — helps you map Terraform blocks with AWS concepts.

Manual AWS EC2 Creation Steps

Login to AWS Console → EC2.

Click Launch Instance.

Choose:

Name: test-instance

AMI: Amazon Linux 2

Instance type: t2.micro

Key pair: select or create new

Security group: allow SSH (port 22)

Storage: default (8 GB)

Click Launch Instance ✅

🧩 Purpose:
Know the parameters Terraform will later automate — ami, instance_type, key_name, vpc_security_group_ids, etc.

32️⃣ Create First Resource on AWS using Terraform (EC2 Instance)

Terraform automates all those manual steps!

main.tf
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform-EC2"
  }
}

Commands
terraform init
terraform plan
terraform apply -auto-approve


✅ Output: EC2 instance will appear on AWS → EC2 → Instances.

🧠 Interview Tip:
Terraform converts .tf files → creates Execution Plan → applies through AWS API using the provider plugin.

33️⃣ How to Create AWS SSH Key and Read a File in Terraform

Terraform can create key pairs dynamically or use existing .pem files.

Option 1: Create Key Pair in AWS Console

Navigate to EC2 → Key Pairs → Create key pair

Choose type = RSA, name = terraform-key

It downloads terraform-key.pem

Option 2: Create Key Pair using Terraform
resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


✅ The file() function reads contents of the file directly.

🧠 Tip:

Store your .pem file safely.

Terraform can reuse the same SSH key for multiple instances.

34️⃣ How to Assign Key to EC2 Instance in Terraform

Attach the created or existing key to EC2 resource.

resource "aws_instance" "webserver" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  tags = {
    Name = "EC2-With-Key"
  }
}


✅ After applying, connect via:

ssh -i "terraform-key.pem" ec2-user@<public-ip>

35️⃣ Create a Security Group in AWS Using Terraform

Security Groups = AWS firewall rules.

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


✅ Terraform creates the security group with inbound/outbound rules.

36️⃣ Dynamic Block in Terraform

Used to generate repeated nested blocks (like multiple ingress rules) dynamically.

Example:
variable "ports" {
  default = [22, 80, 443]
}

resource "aws_security_group" "web_sg" {
  name = "web_sg"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


✅ Creates multiple ingress rules for 22, 80, 443.

🧠 Interview Tip: Dynamic blocks = reusable nested configuration (loop inside block).

37️⃣ Assign a Security Group to EC2 Instance

Attach previously created security group to EC2.

resource "aws_instance" "webserver" {
  ami                    = "ami-0dee22c13ea7a9a67"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "EC2-With-SG"
  }
}


✅ The instance is now secure and accessible via defined ports.

38️⃣ Structure Project

Terraform best practices = organize files modularly.

📁 Recommended Folder Structure

terraform-project/
│
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
└── README.md

Purpose

provider.tf → cloud configuration

main.tf → resources

variables.tf → all variables

outputs.tf → outputs after apply

tfvars → real values

README.md → documentation

🧠 Interview Tip: “We follow modular structure so our code is reusable, readable, and production-ready.”

39️⃣ Terraform Taint Command

Marks a resource for forced recreation on next apply.

Example
terraform taint aws_instance.webserver


Then:

terraform apply


✅ Terraform will destroy and recreate the tainted resource.

🧠 Use Case:
When a resource is in a bad state or manually modified.

40️⃣ AWS userData using Terraform (Installing NGINX)

UserData = startup script that runs when instance boots.

Example
resource "aws_instance" "nginx" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "EC2-with-NGINX"
  }
}


✅ After apply → check your instance public IP → open in browser → NGINX welcome page.

🧠 Interview Tip:
UserData scripts help configure instances automatically (install software, edit config, etc.) during provisioning.

⚙️ Summary Table (Topics 31–40)
#	Topic	Key Concept
31	Manual EC2	AWS console steps for understanding parameters
32	EC2 via Terraform	Automating instance creation
33	SSH Key	Create and read key file in Terraform
34	Assign Key	Attach key to EC2 for SSH
35	Security Group	Define inbound/outbound rules
36	Dynamic Block	Generate nested blocks dynamically
37	Assign SG	Attach security group to instance
38	Structure Project	Recommended Terraform folder layout
39	Taint Command	Force recreation of a specific resource
40	userData	Run setup scripts (install NGINX, etc.)
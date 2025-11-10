🧱 Terraform Notes — Part 6 (Topics 41–50)
41️⃣ File Provisioner

📘 Purpose:
Used to copy files from local machine → to a remote resource (like an EC2 instance) after it’s created.

Example
resource "aws_instance" "myec2" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  provisioner "file" {
    source      = "index.html"          # local file
    destination = "/tmp/index.html"     # remote location
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("terraform-key.pem")
    host        = self.public_ip
  }

  tags = {
    Name = "File-Provisioner"
  }
}


✅ What happens:

Terraform launches instance

Then copies index.html to /tmp/index.html inside EC2

🧠 Interview Tip:
Provisioners are for bootstrapping or minor setup tasks, not full configuration management.

42️⃣ Connection Block in File Provisioner

📘 Purpose:
Defines how Terraform connects to the remote resource (SSH or WinRM).

Syntax
connection {
  type        = "ssh"
  user        = "ec2-user"
  private_key = file("terraform-key.pem")
  host        = self.public_ip
}


✅ Terraform uses this connection info for:

file provisioner

remote-exec provisioner

Alternative for Windows:

connection {
  type     = "winrm"
  user     = "Administrator"
  password = "password123"
  host     = self.public_ip
}


🧠 Tip:
Without a valid connection block, remote provisioners will fail.

43️⃣ Local-Exec Provisioner

📘 Purpose:
Runs local system commands (on your laptop or CI/CD runner) after resource creation.

Example
resource "aws_instance" "local_exec_demo" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  provisioner "local-exec" {
    command = "echo Instance ${self.public_ip} created successfully >> output.txt"
  }
}


✅ Result:
After creation, Terraform executes that command locally — appending instance IP to a file.

🧠 Interview Tip:
Use local-exec for post-deployment notifications, local scripts, or integrations.

44️⃣ When in Provisioners (Local-Exec)

📘 Purpose:
when defines at what stage a provisioner should run:

create → run after resource creation

destroy → run before resource destruction

Example
provisioner "local-exec" {
  when    = destroy
  command = "echo Instance destroyed >> output.txt"
}


✅ Runs the command only when resource is being destroyed.

🧠 Note:
If no when given → default is create.

45️⃣ Remote-Exec Provisioner

📘 Purpose:
Executes commands directly inside the remote resource (like SSH into EC2 and run commands).

Example
resource "aws_instance" "remote_exec_demo" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("terraform-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd"
    ]
  }

  tags = {
    Name = "Remote-Exec-EC2"
  }
}


✅ Installs and starts Apache web server automatically on instance launch.

🧠 Use Case:
Server setup, package installation, or script execution immediately after provisioning.

46️⃣ Datasource in Terraform

📘 Definition:
Data sources allow Terraform to read existing information from cloud providers without creating new resources.

Example
data "aws_vpc" "default" {
  default = true
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}


✅ Terraform fetches details of default VPC instead of creating one.

🧠 Interview Tip:
Data sources = "read-only" resources (used to reference existing AWS items).

47️⃣ Use Datasource in Terraform

📘 Example:
Use existing AWS AMI instead of hardcoding AMI ID.

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  tags = {
    Name = "EC2-Using-Datasource"
  }
}


✅ Fetches latest AMI dynamically every time you run plan/apply.

🧠 Advantage:
No need to update AMI ID manually.

48️⃣ Terraform Configurations

📘 Definition:
A set of .tf files that describe your infrastructure.
Every Terraform project = a configuration.

Key Files

provider.tf – provider definition

main.tf – resources

variables.tf – inputs

outputs.tf – outputs

terraform.tfvars – variable values

Example Project
terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
}


🧠 Tip:
You can have multiple configurations for different environments (dev, staging, prod).

49️⃣ Terraform Graph

📘 Purpose:
Generates a visual dependency graph of all resources.

Command
terraform graph > graph.dot


Convert .dot to image:

sudo apt install graphviz
dot -Tpng graph.dot -o graph.png


✅ graph.png shows how Terraform resources depend on each other.

🧠 Interview Tip:
Used for debugging complex dependencies and understanding resource creation order.

50️⃣ Terraform Workspace

📘 Definition:
Workspaces allow you to manage multiple environments (dev, test, prod) using the same configuration but different state files.

Commands
terraform workspace list
terraform workspace new dev
terraform workspace select dev
terraform workspace show

Example Use
resource "aws_s3_bucket" "example" {
  bucket = "ashu-${terraform.workspace}-bucket"
}


✅ Creates:

ashu-dev-bucket in dev workspace

ashu-prod-bucket in prod workspace

🧠 Interview Tip:
Workspaces = environment isolation within a single Terraform configuration.

⚙️ Summary Table (Topics 41–50)
#	Topic	Key Concept
41	File Provisioner	Copy local → remote files
42	Connection Block	Define SSH/WinRM connection for provisioners
43	Local-Exec	Run local system command post creation
44	When	Control when provisioner runs (create/destroy)
45	Remote-Exec	Run commands inside instance
46	Datasource	Fetch existing cloud data (read-only)
47	Use Datasource	Example: fetch latest AMI or VPC info
48	Terraform Configurations	Combination of .tf files for infra
49	Terraform Graph	Visual dependency graph (dot → png)
50	Terraform Workspace	Manage multiple environments with one config 
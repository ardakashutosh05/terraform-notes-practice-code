1️⃣ What is Terraform & Why Terraform?
Definition

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp.
It allows you to define, provision, and manage cloud infrastructure (like AWS, Azure, GCP, etc.) using declarative configuration files.

Why Terraform?
Traditional Way	Terraform Way
Manual setup via web console	Automated setup via code
Human errors likely	Repeatable and version-controlled
Difficult to manage large infra	Scalable and consistent
No easy rollback	Rollback possible using state files
Key Features

✅ Declarative Syntax: Define what you want (not how to create).
✅ Idempotent: Running terraform apply multiple times gives same result.
✅ Cloud Agnostic: Works with AWS, Azure, GCP, etc.
✅ Infrastructure as Code (IaC): Version your infra in Git just like code.
✅ Dependency Management: Terraform automatically handles dependencies between resources.

Ansible vs Terraform
Feature	Ansible	Terraform
Purpose	Configuration Management (install, configure apps)	Infrastructure Provisioning (create VMs, networks, etc.)
Language	YAML	HCL (HashiCorp Configuration Language)
Nature	Procedural – executes tasks step-by-step	Declarative – describes desired final state
State Management	No built-in state tracking	Uses .tfstate file to track resources
Use Case Example	Install Apache on server	Create the server itself
Best For	Post-deployment setup	Infrastructure creation

✅ Summary:

Use Terraform to create infrastructure.

Use Ansible to configure it afterward.

2️⃣ How to Install Terraform in Windows
Steps:

Go to → https://developer.hashicorp.com/terraform/downloads

Download Windows 64-bit .zip file.

Extract the ZIP (e.g., to C:\terraform).

Add Terraform to PATH:

Search for Environment Variables → Edit System Environment Variables

Click Environment Variables → Path → Edit → New

Add path: C:\terraform

Verify Installation:

terraform -version


Output Example:

Terraform v1.9.0


✅ Now Terraform CLI is ready to use on Windows!

3️⃣ How to Install Terraform in Linux
Steps (Ubuntu/Debian based):
sudo apt update
sudo apt install wget unzip -y
wget https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip
unzip terraform_1.9.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -version


Output Example:

Terraform v1.9.0


✅ Installed globally on Linux.

4️⃣ Hello World Terraform Configuration (Windows)
Goal:

Create your first Terraform configuration to deploy a simple AWS resource (example: EC2 or S3 bucket).

Steps:

Create folder:

mkdir terraform-hello
cd terraform-hello


Create main.tf file:

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "ashu-terraform-bucket"
}


Initialize Terraform:

terraform init


(Downloads AWS provider plugin)

Plan the changes:

terraform plan


Apply the configuration:

terraform apply


(Type yes when asked)

Destroy (optional):

terraform destroy


✅ This creates and destroys infrastructure from code.

5️⃣ Hello World Terraform Configuration (Linux)

The steps are identical — only the commands differ slightly due to Linux shell.

mkdir ~/terraform-hello
cd ~/terraform-hello
nano main.tf


Paste same configuration:

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "ashu-terraform-bucket"
}


Then run:

terraform init
terraform plan
terraform apply


✅ Works exactly like Windows.

⚙️ Summary Table (Topics 1–5)
Topic	Key Learning
1. What/Why Terraform	Terraform = Infrastructure as Code; automates infra creation
2. Install on Windows	Download, extract, add PATH
3. Install on Linux	wget + unzip + move binary to /usr/local/bin
4. Hello World (Windows)	Create provider + resource → init → plan → apply
5. Hello World (Linux)	Same as Windows, but Linux commands
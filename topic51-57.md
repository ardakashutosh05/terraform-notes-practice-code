🧭 Terraform Notes — Part 7 (Topics 51 – 57)
51️⃣ Workspace in Terraform (Deep Explanation)

📘 Definition:
A workspace is an isolated state environment within a single Terraform configuration.
Each workspace has its own terraform.tfstate file.

Default Workspace

When you initialize a new Terraform project:

terraform init
terraform workspace list


You’ll see:

* default


✅ Terraform automatically creates a default workspace.

Creating & Switching Workspaces
terraform workspace new dev
terraform workspace new prod
terraform workspace select dev
terraform workspace show

Use Case Example
resource "aws_s3_bucket" "workspace_bucket" {
  bucket = "ashu-${terraform.workspace}-bucket"
}


🔹 When workspace = dev → bucket = ashu-dev-bucket
🔹 When workspace = prod → bucket = ashu-prod-bucket

🧠 Interview Tip:

Workspaces are best for small environment separation (dev/test/prod),
but for large-scale infra → use different state files or modules per environment.

52️⃣ Terraform Module (Concept)

📘 Definition:
A module is a container for multiple resources used together.
It’s basically a reusable Terraform component.

Modules = like functions in programming → you can call them multiple times.

Module Structure
modules/
 └── ec2/
      ├── main.tf
      ├── variables.tf
      └── outputs.tf


Then use it in root configuration:

module "ec2_instance" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  ami           = "ami-0dee22c13ea7a9a67"
}


✅ Terraform loads and executes that module’s code.

🧠 Advantages of Modules

Reusable, modular design

Cleaner structure

Easier collaboration

Reduces duplication

53️⃣ Terraform Modules (Practical Example)

📘 Example Module Code

📁 modules/ec2/main.tf

variable "ami" {}
variable "instance_type" {}

resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "Module-EC2"
  }
}


📁 root/main.tf

provider "aws" {
  region = "ap-south-1"
}

module "ec2_module" {
  source        = "./modules/ec2"
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
}


✅ Terraform now runs the EC2 creation logic from the module.

🧠 Interview Tip:

Modules = building blocks of Terraform infrastructure as code.

54️⃣ Terraform Modules Return Output

📘 Definition:
Modules can return values (like instance ID, IP, etc.) back to the root configuration.

Example

📁 modules/ec2/outputs.tf

output "instance_id" {
  value = aws_instance.myec2.id
}


📁 root/outputs.tf

output "module_instance_id" {
  value = module.ec2_module.instance_id
}


✅ After apply:

module_instance_id = i-0abcd12345xyz


🧠 Use Case:
Pass outputs from one module → input to another (for example, pass VPC ID → EC2 module).

55️⃣ Terraform Backends – S3 Backend

📘 Definition:
Backends define where Terraform stores the state file (terraform.tfstate).
Default = local.
Production = Remote Backend (S3 + DynamoDB).

Example: S3 Backend
terraform {
  backend "s3" {
    bucket = "ashu-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}


✅ Terraform now stores state remotely in the given S3 bucket.

🧠 Advantages of Remote Backend

Team collaboration

Centralized state storage

Versioning and backup

Supports state locking (with DynamoDB)

56️⃣ Terraform Migrate Backend

📘 Purpose:
Used when moving from local state → remote backend (S3, etc.).

Steps

1️⃣ Remove old terraform.tfstate from project
2️⃣ Add new backend block:

terraform {
  backend "s3" {
    bucket = "ashu-terraform-state-bucket"
    key    = "main.tfstate"
    region = "ap-south-1"
  }
}


3️⃣ Run command:

terraform init -migrate-state


✅ Terraform will:

Copy your existing local state to S3

Configure the backend automatically

🧠 Interview Tip:

The -migrate-state flag ensures existing resources are not recreated —
only the state location changes.

57️⃣ Remote Backend State Locking using S3 and DynamoDB

📘 Problem:
When multiple users run Terraform at the same time, state corruption may occur.

📘 Solution:
Enable State Locking using DynamoDB table.

Configuration
terraform {
  backend "s3" {
    bucket         = "ashu-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

DynamoDB Table Setup

Table name: terraform-lock-table

Partition key: LockID (String)

✅ Terraform automatically creates a lock entry when someone runs terraform apply, and releases it when done.

🧠 Benefits of S3 + DynamoDB Backend

Feature	Description
Remote State Storage	S3 bucket holds the .tfstate file
State Locking	DynamoDB prevents concurrent operations
Versioning	Optional S3 versioning = state history
Security	S3 encryption, IAM access control
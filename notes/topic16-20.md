🧱 Terraform Notes — Part 4 (Topics 16–20)
1️⃣6️⃣ How to Use Map Variable Dynamically

You already know map variables (key–value pairs).
Now, we’ll use them dynamically — so Terraform picks values automatically based on another variable (like environment).

Example

variables.tf

variable "env" {
  description = "Environment"
  default     = "dev"
}

variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    test = "t2.small"
    prod = "t3.micro"
  }
}


main.tf

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type[var.env]
}

Explanation

var.env acts as a dynamic selector.

If env = "prod", Terraform picks t3.micro.

If you change env to dev, Terraform picks t2.micro.

✅ You can dynamically switch configurations (perfect for multi-environment infra).

Run Example
terraform apply -var="env=prod"


✅ Output:

instance_type = "t3.micro"

1️⃣7️⃣ (Skipped in list — continuing sequence)

(Gaurav’s numbering may skip #17 — so we move straight to TFVARs files.)

1️⃣8️⃣ TFVARs Files in Terraform

.tfvars files are used to store variable values separately instead of passing them through CLI or defaults.

This makes your configuration clean, reusable, and secure.

Example

variables.tf

variable "region" {}
variable "bucket_name" {}
variable "instance_type" {}


terraform.tfvars

region        = "ap-south-1"
bucket_name   = "ashu-tfvar-demo"
instance_type = "t2.micro"


main.tf

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}

Run Commands
terraform init
terraform plan
terraform apply


✅ Terraform automatically loads terraform.tfvars file by default.

Advantages

Keeps configuration files clean.

Easily switch values without editing .tf files.

Ideal for large projects or multiple environments.

1️⃣9️⃣ TFVARs Files with Different Name (Custom TFVAR Files)

You can have multiple tfvars files (e.g., dev.tfvars, prod.tfvars, etc.)
Then you can select which one to apply using the -var-file option.

Example

dev.tfvars

region        = "ap-south-1"
bucket_name   = "ashu-dev-bucket"
instance_type = "t2.micro"


prod.tfvars

region        = "ap-southeast-1"
bucket_name   = "ashu-prod-bucket"
instance_type = "t3.medium"


main.tf (same as before)

Run Commands

For dev environment:

terraform apply -var-file="dev.tfvars"


For prod environment:

terraform apply -var-file="prod.tfvars"


✅ Terraform picks variables from the specified file.

Advantages

Switch environments easily.

Avoids editing core .tf files.

Recommended for CI/CD pipelines.

2️⃣0️⃣ Read Environment Variables in Terraform Configurations

Terraform can read environment variables directly from your system using two methods:

Method 1: Using env() function
output "aws_profile" {
  value = env("AWS_PROFILE")
}


Run:

export AWS_PROFILE=default
terraform apply


✅ Output:

aws_profile = "default"

Method 2: Prefixing with TF_VAR_

If you set an environment variable with prefix TF_VAR_, Terraform treats it as a variable automatically.

Example

variables.tf

variable "region" {}


Set environment variable:

export TF_VAR_region="ap-south-1"


Run:

terraform plan


✅ Terraform will automatically use "ap-south-1" for var.region.

Windows PowerShell Example
$env:TF_VAR_region="ap-south-1"
terraform plan

Use Case

This is very useful in:

CI/CD systems (Jenkins, GitHub Actions)

Secret handling (AWS keys, tokens)

Automated pipelines

⚙️ Summary Table (Topics 16–20)
Topic	Key Learning
16. Dynamic Map Variable	Use another variable to select map key dynamically
18. TFVARs File	Store variable values separately in terraform.tfvars
19. Custom TFVARs	Use multiple .tfvars files with -var-file flag
20. Environment Variables	Use env() or TF_VAR_ prefix to read OS-level values
🏁 FINAL TAKEAWAYS

✅ Terraform Core Concepts Recap

HCL Language → Easy & declarative

Providers → Connect Terraform to AWS, Azure, GCP

State File → Tracks resources for future changes

Variables → Make configuration dynamic

Functions, Lists, Maps → Enable reusability

TFVARs / ENV Vars → Manage environments safely

🌱 Real-World Pro Tip:
In professional Terraform projects, you’ll usually find this folder structure:

terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── dev.tfvars
├── prod.tfvars
└── provider.tf


Then your CI/CD pipeline runs commands like:

terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars" -auto-approve
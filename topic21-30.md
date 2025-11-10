🧱 Terraform Notes — Part 5 (Topics 21–30)
2️⃣1️⃣ Terraform Core and Terraform Plugin

Terraform’s architecture has two main components:

Terraform Core

Terraform Plugins (Providers)

1️⃣ Terraform Core

The engine of Terraform.

Written in Go language by HashiCorp.

Handles:

Reading .tf files

Creating execution plans

Managing the state file

Communicating with plugins

Performing apply/destroy actions

✅ Core = Brain of Terraform.

2️⃣ Terraform Plugin

Plugins are external binaries (separate executables).

Each plugin communicates with a specific cloud/service.

Examples:

Plugin Type	Example
Cloud Provider	AWS, Azure, Google, DigitalOcean
Version Control	GitHub, GitLab
Other Services	Docker, Kubernetes, Vault

✅ Terraform downloads plugins automatically during terraform init.

Architecture Diagram (Simplified)
   +------------------------+
   |     Terraform Core     |
   |------------------------|
   | - Parser (.tf files)   |
   | - State Management     |
   | - Plan/Apply Logic     |
   +------------------------+
              ↓
     +----------------+
     |   Provider     |
     |  (AWS, GitHub) |
     +----------------+
              ↓
       Cloud APIs (AWS, GitHub)

2️⃣2️⃣ Creating First Terraform Resource (GitHub Repository)

Terraform can manage not only cloud infra (like AWS) but also services like GitHub, Docker, etc.

Goal

Create a GitHub repository using Terraform.

Step 1️⃣: Create main.tf
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "YOUR_GITHUB_PERSONAL_ACCESS_TOKEN"
}

resource "github_repository" "myrepo" {
  name        = "terraform-demo-repo"
  description = "Repository created using Terraform"
  visibility  = "public"
}

Step 2️⃣: Initialize
terraform init


→ Downloads the GitHub provider plugin.

Step 3️⃣: Plan
terraform plan


→ Shows what will be created.

Step 4️⃣: Apply
terraform apply


→ Terraform will create the repository on GitHub.

✅ Check on GitHub:
Your repo terraform-demo-repo will be visible.

2️⃣3️⃣ Terraform Apply

terraform apply is one of the most used commands — it executes the plan and creates or modifies real infrastructure.

Usage
terraform apply


or with auto-approval (no prompt):

terraform apply -auto-approve

What Happens Internally

Reads all .tf files.

Compares configuration with state file.

Displays execution plan.

Waits for confirmation (yes).

Creates, updates, or deletes resources.

✅ Best Practice:
Always run terraform plan before apply.

2️⃣4️⃣ Terraform .tfstate File and Destroy Command
Terraform State File (terraform.tfstate)

This file keeps track of all resources that Terraform manages.

Purpose

Maps real-world resources to Terraform configuration.

Helps Terraform know what already exists.

Enables incremental updates instead of recreating everything.

Example

After creating a bucket:

{
  "resources": [
    {
      "type": "aws_s3_bucket",
      "name": "mybucket",
      "instances": [
        {
          "attributes": {
            "bucket": "ashu-demo-bucket",
            "region": "ap-south-1"
          }
        }
      ]
    }
  ]
}


✅ Never manually edit this file!

Location

By default → terraform.tfstate in the project directory.
Can be stored remotely (e.g., in S3 bucket) for team use.

2️⃣5️⃣ Terraform Destroy

This command removes all resources that were created by Terraform.

Usage
terraform destroy


Terraform reads the state file → identifies all resources → deletes them safely.

Auto Approve
terraform destroy -auto-approve


✅ Used for cleanup or testing.

Tip

If you delete a resource manually (outside Terraform), Terraform will still think it exists until you run terraform refresh.

2️⃣6️⃣ Terraform Validate Command

Checks whether your configuration files are syntactically valid.

Usage
terraform validate


✅ Output Example:

Success! The configuration is valid.


If errors exist:

Error: Missing required argument


Purpose:
Use before plan or apply to catch typos, missing braces, etc.

2️⃣7️⃣ Terraform Refresh

Synchronizes the state file with real infrastructure.

Usage
terraform refresh

What It Does

Checks actual resource status from provider.

Updates terraform.tfstate with any manual changes made outside Terraform.

✅ Example:
If you deleted an S3 bucket manually from AWS Console,
terraform refresh will update the state and mark it as removed.

2️⃣8️⃣ Terraform Output

Displays output values defined in configuration.

Example

outputs.tf

output "bucket_name" {
  value = aws_s3_bucket.mybucket.bucket
}


After apply:

terraform output


✅ Output:

bucket_name = "ashu-demo-bucket"

Use Case

Share dynamic values (like instance IP, bucket name).

Used in pipelines (Jenkins, GitHub Actions) to pass Terraform outputs to next steps.

2️⃣9️⃣ Terraform Console

Interactive shell to test expressions, functions, and variables.

Usage
terraform console


Now try:

> var.region
> length([1,2,3])
> upper("terraform")


✅ Very useful for debugging variable logic or outputs.

3️⃣0️⃣ Terraform fmt

Formats all Terraform configuration files (.tf) to follow standard style guidelines.

Usage
terraform fmt


✅ Reformats spacing, indentation, alignment automatically.

Example Before
provider "aws"{
region="ap-south-1"}

After Running terraform fmt
provider "aws" {
  region = "ap-south-1"
}


✅ Keeps your code clean and readable — always use before commits!

⚙️ Summary Table (Topics 21–30)
Topic	Key Learning
21. Terraform Core & Plugins	Core = brain; Plugins = connect to providers like AWS, GitHub
22. GitHub Resource	Create GitHub repo with provider token
23. Apply	Executes plan → creates infra
24. State File	Tracks infra; don’t edit manually
25. Destroy	Deletes all managed resources
26. Validate	Checks syntax of .tf files
27. Refresh	Updates state file with real infra state
28. Output	Displays values defined in output blocks
29. Console	Test variables/functions interactively
30. fmt	Auto-format Terraform code

✅ Pro Tip for Projects
Before every commit or pipeline run:

terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve


For cleanup:

terraform destroy -auto-approve

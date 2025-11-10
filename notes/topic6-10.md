🧱 Terraform Notes — Part 2 (Topics 6 to 10)

6️⃣ Hello World Terraform Configurations in JSON Format

Terraform supports HCL (HashiCorp Configuration Language) and JSON.
Both describe the same infrastructure; JSON is just an alternative syntax.

Example in HCL
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "ashu-terraform-hcl"
}

Same Configuration in JSON

Save file as main.tf.json

{
  "provider": {
    "aws": {
      "region": "ap-south-1"
    }
  },
  "resource": {
    "aws_s3_bucket": {
      "mybucket": {
        "bucket": "ashu-terraform-json"
      }
    }
  }
}

Run Commands
terraform init
terraform plan
terraform apply


✅ Terraform automatically detects .tf.json files.

Note:
JSON format is machine-friendly, while HCL is developer-friendly.
→ Most engineers prefer HCL.

7️⃣ Multiple Blocks in a Single Terraform File

You can define multiple resources/providers inside one .tf file.

Example
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "ashu-bucket-1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "ashu-bucket-2"
}


Explanation:

Both buckets will be created by the same provider.

Terraform reads the entire file top to bottom before applying.

✅ Best Practice:
You can group related resources together in one file (but keep large projects modular).

8️⃣ Multiple Terraform Files in the Same Directory

Terraform merges all .tf files in the same folder into a single configuration during execution.
Order doesn’t matter; it’s handled automatically.

Example:

📁 Folder Structure

/terraform-project
 ├── provider.tf
 ├── main.tf
 └── output.tf


provider.tf

provider "aws" {
  region = "ap-south-1"
}


main.tf

resource "aws_s3_bucket" "mybucket" {
  bucket = "ashu-bucket-demo"
}


output.tf

output "bucket_name" {
  value = aws_s3_bucket.mybucket.bucket
}


Then run:

terraform init
terraform plan
terraform apply


✅ Terraform automatically reads and executes all .tf files together.

Advantages

Better organization.

Easier collaboration.

Easier debugging.

9️⃣ Variables in Terraform

Variables allow parameterization of your configuration (no hard-coding values).

Syntax
variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

provider "aws" {
  region = var.region
}

Use Case

Instead of writing "ap-south-1" directly in the provider block, use var.region.

How Terraform Resolves Variable Values

Default value (if given)

TFVARs file

Command-line -var flag

Environment variables
→ Later sources override earlier ones.

✅ Command to view variables

terraform console
> var.region
"ap-south-1"

🔟 Pass Variable Value from Command Line

When no default is set, you can pass the value manually.

Example

main.tf

variable "bucket_name" {
  description = "Name of the S3 bucket"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

Option 1: Inline Variable
terraform apply -var="bucket_name=ashu-cli-bucket"

Option 2: During Prompt

If no default and not passed:

var.bucket_name
  Name of the S3 bucket
  Enter a value:


Then type the name manually.

✅ Best Practices

Use variables for all configurable values (region, instance type, tags etc.).

Use -var for testing small changes.

For large projects, use .tfvars files (covered in later topics).

⚙️ Summary Table (Topics 6–10)
Topic	Key Learning
6. JSON Format	Terraform supports .tf.json – same logic as HCL
7. Multiple Blocks	You can define multiple resources/providers in one file
8. Multiple Files	Terraform automatically merges all .tf files in same dir
9. Variable	Used to make configuration dynamic and reusable
10. Pass Variable Value	Use -var or prompt to supply values manually
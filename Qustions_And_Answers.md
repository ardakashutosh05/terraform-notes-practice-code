🌍 Terraform Interview Questions & Answers (Complete Guide)
🟢 Basic Level (Conceptual Understanding)
1. What is Terraform?

Answer:
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp that allows you to define, provision, and manage cloud infrastructure using a declarative configuration language (HCL - HashiCorp Configuration Language).

2. Why do we use Terraform?

Answer:

Automates infrastructure provisioning

Ensures infrastructure consistency

Version control of infrastructure

Multi-cloud support (AWS, Azure, GCP, etc.)

3. What is Infrastructure as Code (IaC)?

Answer:
IaC means managing and provisioning infrastructure (servers, networks, etc.) using code instead of manual processes.

4. What language does Terraform use?

Answer:
Terraform uses HCL (HashiCorp Configuration Language), a declarative language designed for describing infrastructure.

5. What is a Terraform provider?

Answer:
A provider is a plugin that allows Terraform to interact with APIs of cloud platforms or services (e.g., AWS, Azure, GCP, GitHub).

6. What is a Terraform resource?

Answer:
A resource defines a single piece of infrastructure, such as an EC2 instance, S3 bucket, or security group.

7. Difference between Terraform and Ansible?
Feature	Terraform	Ansible
Type	IaC (Provisioning)	Configuration Management
Language	Declarative (HCL)	Procedural (YAML)
Focus	Infrastructure setup	Application setup/configuration
Execution	Creates immutable infrastructure	Modifies existing infrastructure
8. What is Terraform init command used for?

Answer:
terraform init initializes the working directory and downloads the required provider plugins.

9. What does terraform plan do?

Answer:
It shows the execution plan — what changes Terraform will make before actually applying them.

10. What does terraform apply do?

Answer:
It creates or updates infrastructure according to the configuration files.

11. What does terraform destroy do?

Answer:
Deletes all resources that Terraform created.

12. What is terraform fmt used for?

Answer:
Formats your Terraform code to follow standard HCL style.

13. What is terraform validate command?

Answer:
Validates syntax and configuration correctness in Terraform files.

14. What is the .tfstate file?

Answer:

Stores the current state of your infrastructure.

Used by Terraform to determine what changes are needed.

15. What is the purpose of the .terraform.lock.hcl file?

Answer:
It locks the versions of providers used to ensure consistent runs across different environments.

16. What is a Terraform variable?

Answer:
Variables are used to make Terraform configurations dynamic and reusable.

17. What are TFVAR files?

Answer:
.tfvars files are used to store variable values separately from the main configuration.

🟡 Intermediate Level (Configuration & State Management)
18. What is the difference between local and remote state?
Type	Description
Local State	Stored on your local machine as a .tfstate file
Remote State	Stored in cloud storage like S3, GCS, Azure Blob (used for team collaboration)
19. What is State Locking in Terraform?

Answer:
Prevents multiple users from modifying the state file at the same time.
Example: Using S3 + DynamoDB for remote backend locking.

20. How to read environment variables in Terraform?

Answer:
You can use:

variable "region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.region
}


And override it with:

export TF_VAR_region="ap-south-1"

21. What is a data source in Terraform?

Answer:
A data source allows you to fetch information from outside Terraform (e.g., existing AWS AMIs, existing resources).

Example:

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["ubuntu/images/*"]
  }
}

22. What is a dynamic block in Terraform?

Answer:
Dynamic blocks allow you to generate multiple nested configuration blocks dynamically using loops.

Example:

dynamic "ingress" {
  for_each = var.ports
  content {
    from_port = ingress.value
    to_port   = ingress.value
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

23. What is the use of provisioners in Terraform?

Answer:
Provisioners allow you to run commands or scripts on a local or remote machine after resource creation.

Types:

local-exec

remote-exec

file provisioner

24. What is Terraform refresh?

Answer:
Synchronizes the state file with the real-world infrastructure.

Command:

terraform refresh

25. What is Terraform taint command used for?

Answer:
Marks a resource for recreation during the next terraform apply.

🔵 Advanced Level (Modules, Workspaces, and Backends)
26. What is a Terraform module?

Answer:
A module is a reusable block of Terraform code (a folder containing .tf files) that can be called from other configurations.

27. How do you call a module in Terraform?

Example:

module "ec2_instance" {
  source = "./modules/ec2"
  instance_type = "t2.micro"
}

28. What are outputs in Terraform modules?

Answer:
Outputs are used to export information from a module to be used elsewhere.

Example:

output "instance_ip" {
  value = aws_instance.my_ec2.public_ip
}

29. What is a Terraform workspace?

Answer:
Workspaces allow you to manage multiple environments (dev, test, prod) using the same configuration files.

Commands:

terraform workspace new dev
terraform workspace select dev
terraform workspace list

30. What is Terraform backend?

Answer:
A backend determines where Terraform stores its state (locally or remotely).

Example (AWS S3 backend):

terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state/terraform.tfstate"
    region = "ap-south-1"
  }
}

31. What is Terraform remote backend state locking?

Answer:
Prevents multiple users from editing the state at the same time.
Usually implemented with S3 for storage and DynamoDB for locking.

32. How does Terraform handle dependencies between resources?

Answer:
Terraform automatically builds a dependency graph based on references between resources.
You can also define dependencies explicitly using:

depends_on = [aws_security_group.sg]

33. How do you import existing resources into Terraform?

Answer:

terraform import aws_instance.my_instance i-0abc123456789

34. What happens during terraform plan and apply internally?

Plan: Compares current state with desired configuration → creates an execution plan.

Apply: Executes that plan and updates the .tfstate file.

35. How do you upgrade Terraform provider versions?
terraform init -upgrade

36. What is the difference between count and for_each?
Feature	count	for_each
Type	Numeric	Map or Set
Index	count.index	each.key / each.value
Use Case	Repeated identical resources	Different resource configurations
37. How can you handle secrets in Terraform?

Answer:
Use environment variables, AWS Secrets Manager, or external vaults.
Avoid hardcoding secrets in .tf files.

38. What is drift in Terraform?

Answer:
Drift occurs when the actual infrastructure changes outside of Terraform, causing a mismatch between real and state.

39. What are best practices for Terraform?

✅ Use version control (Git)
✅ Use remote state backend
✅ Use variables and modules
✅ Format & validate code (fmt, validate)
✅ Enable state locking
✅ Avoid hardcoding secrets

40. What are some common Terraform commands?
Command	Description
terraform init	Initialize directory
terraform plan	Show changes
terraform apply	Apply changes
terraform destroy	Destroy resources
terraform fmt	Format code
terraform validate	Validate config
terraform output	Show outputs
terraform graph	Visualize dependency graph
terraform workspace	Manage environments

🧠 Pro Tip for Interview

If interviewer asks: "How Terraform helps in saving cost?"
👉 You can answer:
“Terraform helps by automating resource creation, managing lifecycle efficiently, destroying unused infrastructure automatically, and enabling reusable infrastructure code for multiple environments.”
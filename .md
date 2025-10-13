💥 Complete Terraform Commands List (With Use & Example)

🧩 1️⃣ Initialization Command

✅ Command:

terraform init


📘 Use:
Terraform project initialize karta hai — plugins (providers) download karta hai, jaise AWS, GitHub, Azure, etc.

💡 Example:

terraform init

🧱 2️⃣ Validate Configuration

✅ Command:

terraform validate


📘 Use:
Configuration (.tf files) syntax aur structure validate karta hai (koi error to nahi).

💡 Example:

terraform validate

📄 3️⃣ Format Files

✅ Command:

terraform fmt


📘 Use:
Terraform code ko proper format me laata hai (clean aur readable).

💡 Example:

terraform fmt

🔍 4️⃣ Plan (Preview Changes)

✅ Command:

terraform plan


📘 Use:
Dekhta hai Terraform kya-kya change karega (create/update/destroy) — preview only.

💡 Example:

terraform plan
terraform plan -var 'username=ashu'
terraform plan -var-file="terraform.tfvars"

⚙️ 5️⃣ Apply Configuration

✅ Command:

terraform apply


📘 Use:
Plan ke hisaab se resources create/update karta hai.

💡 Example:

terraform apply
terraform apply --auto-approve

💣 6️⃣ Destroy Resources

✅ Command:

terraform destroy


📘 Use:
Terraform ke dwara banaye gaye sabhi resources ko delete karta hai.

💡 Example:

terraform destroy
terraform destroy --auto-approve
terraform destroy -target=github_repository.terraform-first-repo --auto-approve

🎯 7️⃣ Target Specific Resource

✅ Command:

terraform apply -target=<resource_name>
terraform destroy -target=<resource_name>


📘 Use:
Sirf ek ya kuch specific resources apply/destroy karta hai.

💡 Example:

terraform destroy -target=github_repository.terraform-first-repo --auto-approve

📦 8️⃣ Show Current State

✅ Command:

terraform show


📘 Use:
Terraform state file ka content (current deployed resources) dikhata hai.

💡 Example:

terraform show

📜 9️⃣ List Resources in State

✅ Command:

terraform state list


📘 Use:
Current Terraform state me track ho rahe resources ki list dikhata hai.

💡 Example:

terraform state list

🧹 🔟 Remove Resource from State

✅ Command:

terraform state rm <resource_name>


📘 Use:
State se kisi resource ko manually remove karta hai (useful if deleted outside Terraform).

💡 Example:

terraform state rm github_repository.terraform-first-repo

💾 1️⃣1️⃣ Output Values

✅ Command:

terraform output


📘 Use:
Output variables ke values show karta hai (jo output {} blocks me define kiye ho).

💡 Example:

terraform output

🔄 1️⃣2️⃣ Refresh State

✅ Command:

terraform refresh


📘 Use:
Cloud me actual resources ke state ke sath Terraform state ko sync karta hai.

💡 Example:

terraform refresh

🧠 1️⃣3️⃣ Import Existing Resource

✅ Command:

terraform import <resource_type.name> <existing_id>


📘 Use:
Already existing resource ko Terraform ke control me laata hai.

💡 Example:

terraform import github_repository.existing-repo existing-repo-name

🧾 1️⃣4️⃣ Workspace Commands

✅ Command:

terraform workspace list
terraform workspace new dev
terraform workspace select dev
terraform workspace delete dev


📘 Use:
Multiple environments (dev, test, prod) manage karne ke liye.

💡 Example:

terraform workspace new staging

⚙️ 1️⃣5️⃣ Version Check

✅ Command:

terraform version


📘 Use:
Installed Terraform version dikhata hai.

💡 Example:

terraform version

💥 1️⃣6️⃣ Remove Terraform Cache

✅ Command:

rm -rf .terraform/
rm .terraform.lock.hcl


📘 Use:
Provider cache delete karta hai (useful if plugin errors aate hain).

💡 Example:

rm -rf .terraform/

🪶 1️⃣7️⃣ Compact Warnings

✅ Command:

terraform plan -compact-warnings


📘 Use:
Warning messages kam deta hai (useful for cleaner output).

🗂️ 1️⃣8️⃣ Variables Handling

✅ Command:

export TF_VAR_github_token="your_token"
terraform apply


📘 Use:
Environment variable ke through secret values (jaise GitHub token) set karta hai.

🧩 1️⃣9️⃣ Help Command

✅ Command:

terraform --help


📘 Use:
All commands aur unka short help message show karta hai.

⚡ 2️⃣0️⃣ Plan File Save & Apply Later

✅ Command:

terraform plan -out=tfplan
terraform apply tfplan


📘 Use:
Plan ko file me save karke later apply kar sakte ho.

🧰 BONUS — Common Terraform Workflow
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply --auto-approve
terraform state list
terraform destroy -target=resource_name --auto-approve

resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My first resource for using terraform"

  visibility = "public"
auto_init = true
  
}


# terraform providers
# terraform init
# terraform apply --auto-approve
# terraform destroy --auto-approve
# terraform state list
# terraform destroy -target=github_repository.terraform-first-repo1
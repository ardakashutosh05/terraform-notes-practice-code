provider "github" {
   token=var.github_token

}


resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My first resource for using terraform"

  visibility = "public"
auto_init = true
  
}
# terraform providers
# terraform init
# terraform apply --auto-approve
# terraform destroy

provider "github" {
   token=var.github_token

}


resource "github_repository" "terraform-first-repo1" {
  name        = "1-repo-from-terraform"
  description = "My first resource for using terraform"

  visibility = "public"
auto_init = true
  
}

resource "github_repository" "terraform-second-repo2" {
  name        = "second-repo-from-terraform"
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
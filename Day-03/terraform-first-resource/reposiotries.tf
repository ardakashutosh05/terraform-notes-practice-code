
resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My first resource for using terraform"

  visibility = "public"
  auto_init  = true

}

output "terraform-first-repo-url" {
  value = github_repository.terraform-first-repo.html_url

}


# terraform providers
# terraform init
# terraform apply --auto-approve
# terraform destroy --auto-approve
# terraform state list
# terraform destroy -target=github_repository.terraform-first-repo1
# terraform refresh
# terraform show
# terraform console # is se new cansole milta hai "exit"
# terraform fmt # code agjast in line 
# terraform validate
#terraform taint # is se jobhi bana hi usko doun karke filr se banate hai recreatr
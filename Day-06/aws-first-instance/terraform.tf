terraform {
  required_version = "1.13.3"


  # terraform version comand

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }

}
# terraform graph | dot -Tpdf > graph.pdf


# terraform plan --var-file dev-tfvars.tfvars # is me do sil me aga intan type hi to tfvers pahile ga  agar ye kamand dali to is file me se le ga 
# terraform workspace # terraform workspace new dev # creat new work space
# terraform workspace show
# terraform workspace select dev
# terraform workspace list
# terraform workspace --help
#
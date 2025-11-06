# creating instance


module "mywebserver" {
  source = "./modules/webserver"

  instance_type = var.instance_type
  image_id      = var.image_id
}
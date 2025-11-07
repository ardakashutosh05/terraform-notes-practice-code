# creating instance


module "mywebserver" {
  source        = "./modules/webserver"
  public_key    = var.ashu_key_pub
  instance_type = var.instance_type
  image_id      = var.image_id

  key_name = "${var.key_name}"
}

output mypublicIP {
  value = module.mywebserver.publicIP
}

##
#####/root/main.tf#####
# locals {
#   cidr = "10.0.0.0/16"
# }

module "networking" {
  source          = "./networking"
  my_cidr         = local.cidr
  security_groups = local.security_groups
  access_ip       = var.access_ip
  public_sub_cnt  = 2
  private_sub_cnt = 3
  total_subnet    = 20
  db_subnet       = true
  public_cidrs    = [for i in range(2, 100, 2) : cidrsubnet(local.cidr, 8, i)]
  private_cidrs   = [for i in range(1, 100, 2) : cidrsubnet(local.cidr, 8, i)]
}


module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "8.0.23"
  db_instance_class      = "db.t2.micro"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
  db_identifier          = "db"
  skip_final_snapshot    = true
}


module "loadbalancing" {
  source                 = "./loadbalancing"
  lb_sg                  = module.networking.public_sg
  lb_subnet              = module.networking.public_subnet
  tg_port                = 8000
  tg_protocol            = "HTTP"
  vpc_id                 = module.networking.tg_vpc_id
  lb_healthy_thresold    = 2
  lb_unhealthy_threshold = 2
  lb_timeout             = 3
  lb_interval            = 30
  lb_listener_port       = 80
  ln_listener_protocol   = "HTTP"
}

module "compute" {
  source              = "./compute"
  instance_count      = 2
  instance_type       = "t2.micro"
  public_sg           = module.networking.public_sg
  public_subnet       = module.networking.public_subnet
  volume_size         = 10
  key_name            = "keynode"
  public_key_path     = "./keynode.pub"
  user_data_path      = "./userdata.tpl"
  db_endpoint         = module.database.db_endpoint
  db_name             = var.db_name
  db_username         = var.db_username
  db_pass             = var.db_password
  lb_target_group_arn = module.loadbalancing.lb_target_group_arn
  tg_port             = 8000
}
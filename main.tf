module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  env_name = var.env_name
}

module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  env_name = var.env_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}


module "compute" {
  source = "./modules/compute"

  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id

  public_sg_id      = module.network.public_sg_id

  vpc_cidr          = var.vpc_cidr
  env_name          = var.env_name
}

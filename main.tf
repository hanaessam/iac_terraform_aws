module "network" {
  source               = "./modules/network"
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  env_name             = var.env_name
  public_subnet1_cidr  = var.public_subnet1_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  public_subnet2_cidr  = var.public_subnet2_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
}

module "compute" {
  source             = "./modules/compute"
  env_name           = var.env_name
  ami                = var.ami
  instance_type      = var.instance_type
  vpc_id             = module.network.vpc_id
  vpc_cidr           = module.network.vpc_cidr
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}

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
  source = "./modules/compute"

  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id1
  private_subnet_id = module.network.private_subnet_id1
  public_sg_id      = module.network.public_sg_id

  vpc_cidr = var.vpc_cidr
  env_name = var.env_name

  ami           = var.ami
  instance_type = var.instance_type
}

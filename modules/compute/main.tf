# Security Groups
module "security_groups" {
  source   = "./sg"
  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr
  env_name = var.env_name
}

# Key Pair for Bastion Host
module "key_pair" {
  source   = "./key_pair"
  env_name = var.env_name
}

# EC2 Instances
module "ec2" {
  source             = "./ec2"
  ami                = var.ami
  instance_type      = var.instance_type
  env_name           = var.env_name
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  public_sg_id       = module.security_groups.public_sg_id
  private_sg_id      = module.security_groups.private_sg_id
  key_name           = module.key_pair.key_pair_name
}

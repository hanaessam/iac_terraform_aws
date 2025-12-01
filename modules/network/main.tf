module "vpc" {
  source   = "./vpc"
  region   = var.region
  vpc_cidr = var.vpc_cidr
  env_name = var.env_name
}

# Create public subnets
module "subnets" {
  source   = "./subnet"
  vpc_id   = module.vpc.vpc_id
  region   = var.region
  env_name = var.env_name
  public_subnet_cidrs = [
    var.public_subnet1_cidr,
    var.public_subnet2_cidr
  ]

  private_subnet_cidrs = [
    var.private_subnet1_cidr,
    var.private_subnet2_cidr
  ]
}

# Create an Internet Gateway
module "igw" {
  source   = "./igw"
  vpc_id   = module.vpc.vpc_id
  env_name = var.env_name
}

# Create NAT Gateway in first public subnet
module "nat" {
  source    = "./nat"
  env_name  = var.env_name
  subnet_id = module.subnets.public_subnet_ids[0]
}


# Create a public route table
module "public_rt" {
  source           = "./route_table"
  vpc_id           = module.vpc.vpc_id
  env_name         = var.env_name
  route_table_name = "public"
  gateway_id       = module.igw.igw_id

}

# Create a private route table
module "private_rt" {
  source           = "./route_table"
  vpc_id           = module.vpc.vpc_id
  env_name         = var.env_name
  route_table_name = "private"
  gateway_id       = module.nat.nat_gateway_id
}

# Associate route table with subnets
module "public_assoc" {
  source         = "./route_table_assoc"
  subnet_ids     = module.subnets.public_subnet_ids
  route_table_id = module.public_rt.route_table_id
}

module "private_assoc" {
  source         = "./route_table_assoc"
  subnet_ids     = module.subnets.private_subnet_ids
  route_table_id = module.private_rt.route_table_id
}


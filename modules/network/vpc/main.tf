resource "aws_vpc" "vpc" {
  region     = var.region
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env_name}-vpc"
  }
}

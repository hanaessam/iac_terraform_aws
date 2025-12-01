resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = "${var.region}${element(["a", "b", "c", "d"], count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = "${var.region}${element(["a", "b", "c", "d"], count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-private-subnet-${count.index + 1}"
  }
}


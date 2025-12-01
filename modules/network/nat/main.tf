# Create NAT Gateway in public subnet
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.env_name}-nat-eip"
  }

}

# Create NAT Gateway in public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.env_name}-nat-gateway"
  }
}

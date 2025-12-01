# Create a public route table
resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_name}-${var.route_table_name}-rt"
  }
}

# Create a route 
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}
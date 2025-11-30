output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id1" {
  value = aws_subnet.public_subnet1.id
}

output "private_subnet_id1" {
  value = aws_subnet.private_subnet1.id
}

output "public_subnet_id2" {
  value = aws_subnet.public_subnet2.id

}

output "private_subnet_id2" {
  value = aws_subnet.private_subnet2.id
}


output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "nat_eip" {
  value = aws_eip.nat_eip.public_ip
}

output "public_subnet_ids" {
  description = "List of subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private_subnets[*].id
}
output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "app_private_ip" {
  description = "Private IP of the application server"
  value       = aws_instance.app.private_ip
}

output "bastion_instance_id" {
  description = "Instance ID of the bastion host"
  value       = aws_instance.bastion.id
}

output "app_instance_id" {
  description = "Instance ID of the application server"
  value       = aws_instance.app.id
}

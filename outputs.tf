output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.compute.bastion_public_ip
}

output "app_private_ip" {
  description = "Private IP of the application server"
  value       = module.compute.app_private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "nat_gateway_ip" {
  description = "Elastic IP attached to NAT Gateway"
  value       = module.network.nat_eip
}

output "bastion_ssh_key_path" {
  description = "Local path to bastion SSH private key"
  value       = module.compute.bastion_key_path
}

output "ssh_connection_command" {
  description = "Command to connect to bastion"
  value       = "ssh -i ${module.compute.bastion_key_path} ec2-user@${module.compute.bastion_public_ip}"
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "app_private_ip" {
  value = module.ec2.app_private_ip
}

output "bastion_key_path" {
  value = module.key_pair.bastion_key_path
}

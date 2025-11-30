output "private_sg_id" {
  value = aws_security_group.private_sg.id
}
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "app_private_ip" {
  value = aws_instance.app.private_ip
}

output "bastion_key_path" {
  description = "Local path to the bastion SSH private key"
  value       = local_file.bastion_pem.filename
}

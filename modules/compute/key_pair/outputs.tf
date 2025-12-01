output "key_pair_name" {
  description = "Name of the bastion SSH key pair"
  value       = aws_key_pair.bastion_key_pair.key_name
}


output "bastion_key_path" {
  description = "Local path to the bastion SSH private key"
  value       = local_file.bastion_pem.filename
}


output "private_key_pem" {
  description = "PEM formatted private key for the bastion host"
  value       = tls_private_key.bastion_key.private_key_pem

}

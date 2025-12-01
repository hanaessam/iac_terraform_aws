# Generate a TLS private key for the Bastion host
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "${var.env_name}-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# Save the private key to a local file
resource "local_file" "bastion_pem" {
  content         = tls_private_key.bastion_key.private_key_pem
  filename        = "${path.module}/${var.env_name}_bastion_key.pem"
  file_permission = "0400"
}

# Security Group for Private Instances (Allow SSH from Bastion and App Port)
resource "aws_security_group" "private_sg" {
  name        = "${var.env_name}-private-sg"
  description = "App server SG"
  vpc_id      = var.vpc_id

  # Allow SSH only from Bastion SG
  ingress {
    description = "SSH from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.public_sg_id]
  }

  # Allow port 3000 only from VPC
  ingress {
    description = "App port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_name}-private-sg"
  }
}

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




# Create a Bastion Host in the Public Subnet
resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type

  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]

  key_name = aws_key_pair.bastion_key_pair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.env_name}-bastion"
  }
}

# Application EC2 in Private Subnet
resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  # Use same TLS key as bastion
  key_name = aws_key_pair.bastion_key_pair.key_name

  # NO public IP for private subnet servers
  associate_public_ip_address = false

  # Optional: install Node.js
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y gcc-c++ make
              curl -sL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs
              EOF

  tags = {
    Name = "${var.env_name}-app"
  }
}


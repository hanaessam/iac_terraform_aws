# Security Group for Private EC2 (Application) for SSH from Bastion and App traffic
resource "aws_security_group" "private_sg" {
  name        = "${var.env_name}-private-sg"
  description = "App server SG"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.public_sg_id]

  }

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


# RSA key of size 4096 bits
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Key Pair for Bastion Host
resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "${var.env_name}-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh

  depends_on = [tls_private_key.bastion_key]

  provisioner "local-exec" {
    command = "echo '${tls_private_key.bastion_key.private_key_pem}' > ${var.env_name}_bastion_key.pem && chmod 400 ${var.env_name}_bastion_key.pem"
  }
}

# Bastion Host EC2 Instance
resource "aws_instance" "bastion" {
  ami                    = "ami-0fa3fe0fa7920f68e"
  instance_type          = "t2.micro"
  
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]

  key_name = aws_key_pair.bastion_key_pair.key_name

  associate_public_ip_address = true

  tags = {
    Name = "${var.env_name}-bastion"
  }
}







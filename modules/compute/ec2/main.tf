# Create a Bastion Host in the Public Subnet
resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type

  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.public_sg_id]

  key_name = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.env_name}-bastion"
  }
}

# Application EC2 in Private Subnet
resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.private_sg_id]

  # Use same TLS key as bastion
  key_name = var.key_name

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


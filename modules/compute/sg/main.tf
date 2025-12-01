# Security Group: Allow SSH from anywhere
resource "aws_security_group" "public_sg" {
  name        = "${var.env_name}-public-sg"
  description = "Allow SSH from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_name}-public-sg"
  }
}

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
    security_groups = [aws_security_group.public_sg.id]
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

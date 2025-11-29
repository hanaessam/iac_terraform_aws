# Security Group for Private EC2 (Application)
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

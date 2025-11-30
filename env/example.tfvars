# Example Terraform variables file
# Copy this file to dev.tfvars or prod.tfvars and fill in your values

region   = "us-east-1"              # AWS region (e.g., us-east-1, eu-central-1)
vpc_cidr = "10.0.0.0/16"            # VPC CIDR block
env_name = "dev"                    # Environment name (dev, prod, staging, etc.)
public_subnet_cidr  = "10.0.1.0/24" # Public subnet CIDR
private_subnet_cidr = "10.0.2.0/24" # Private subnet CIDR
az                  = "us-east-1a"  # Availability zone

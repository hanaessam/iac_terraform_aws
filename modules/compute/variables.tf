variable "env_name" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID from network module"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR from network module"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs from network module"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs from network module"
}

variable "ami" {
  type    = string
  default = "ami-0fa3fe0fa7920f68e"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

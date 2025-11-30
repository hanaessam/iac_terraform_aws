variable "env_name" {
  type = string
}

variable "vpc_id" { type = string }
variable "public_sg_id" { type = string }
variable "vpc_cidr" { type = string }

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "ami" {
  type    = string
  default = "ami-0fa3fe0fa7920f68e"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

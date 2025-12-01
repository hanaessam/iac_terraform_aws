variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "env_name" {
  type = string
}
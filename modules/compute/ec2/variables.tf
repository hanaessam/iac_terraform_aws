variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "env_name" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}


variable "public_sg_id" {
  type = string
}

variable "private_sg_id" {
  type = string
}

variable "key_name" {

}


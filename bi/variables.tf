variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_cidr" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}


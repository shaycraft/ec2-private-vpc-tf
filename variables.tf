variable "region" {
  type    = string
  default = "us-west-2"
}

variable "ami" {
  description = "ami id for wordpress server"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "ssh_key_public" {
  description = "Public ssh key to use for nginx instance"
  type        = string
}

variable "ssh_key_private" {
  description = "Private ssh key to use for nginx instances"
  type        = string
}